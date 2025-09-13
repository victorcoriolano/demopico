
import 'dart:async';

import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/core/common/auth/domain/value_objects/location_vo.dart';
import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/media_management/services/upload_service.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/factories/spot_factory.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';
import 'package:demopico/features/mapa/domain/usecases/create_spot_uc.dart';
import 'package:demopico/core/common/media_management/usecases/pick_image_uc.dart';
import 'package:demopico/features/mapa/domain/value_objects/attributes_vo.dart';
import 'package:demopico/features/mapa/domain/value_objects/modality_vo.dart';
import 'package:demopico/features/mapa/domain/value_objects/obstacle_vo.dart';
import 'package:demopico/features/mapa/domain/value_objects/rating_vo.dart';
import 'package:demopico/features/mapa/domain/value_objects/type_spot_vo.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddPicoViewModel extends ChangeNotifier {
  static AddPicoViewModel? _addPicoProvider;

  static AddPicoViewModel get getInstance {
    _addPicoProvider ??= AddPicoViewModel(
      pickImageUC: PickImageUc.getInstance(),
      serviceImage: UploadService.getInstance,
      createSpotUc: CreateSpotUc.getInstance,
    );
    return _addPicoProvider!;
  }

  final PickImageUc _pickImageUC;
  final UploadService _uploadService;
  final CreateSpotUc _createSpotUc;

  AddPicoViewModel({
    required PickImageUc pickImageUC,
    required UploadService serviceImage,
    required CreateSpotUc createSpotUc,
  })  : _uploadService = serviceImage,
        _createSpotUc = createSpotUc,
        _pickImageUC = pickImageUC;

  String? errors;

  // --- ENTITIES / VALUE OBJECTS ---
  late ModalitySpot selectedModalidade;
  late AttributesVO attributesVO;
  late ObstacleVo obstaculoVo;
  late TypeSpotVo typeSpotVo;
  late LocationVo locationVO;

  String nomePico = '';
  String descricao = '';
  List<String> imgUrls = [];
  LatLng? latlang;
  bool isValid = false;

  List<FileModel> get files => _pickImageUC.listFile;

  Map<String, bool> utilidadesSelecionadas = {};

  // --- INICIALIZAÇÃO ---
  void initialize(LocationVo location) {
    locationVO = location;
    _updateConfig(ModalitySpot.skate);
  }

  void _updateConfig(ModalitySpot modalidade) {
    selectedModalidade = modalidade;
    attributesVO = SpotFactory.createAttributes(modalidade);
    obstaculoVo = SpotFactory.createObstacles(modalidade);
    typeSpotVo = SpotFactory.createType(modalidade);

    // reset utilidades selecionadas
    utilidadesSelecionadas.clear();
    for (var util in modalidade.utilitiesByModality) {
      utilidadesSelecionadas[util] = false;
    }

    notifyListeners();
  }

  // --- PÁGINA 1 ---
  void atualizarModalidade(ModalitySpot modalidade) => _updateConfig(modalidade); 

  void selecionarUtilidade(String utilidade, bool isSelected) {
    utilidadesSelecionadas[utilidade] = isSelected;
    notifyListeners();
  }

  // --- PÁGINA 2 ---
  void updateAttribute(String attributeName, int rate) {
    debugPrint("Chamou atualizar att - $attributeName - nota: $rate");
    attributesVO = attributesVO.updateRate(attributeName, rate);
    notifyListeners();
  }
  String getDescription(String attribute, int rate){
    return attributesVO.obterDescricao(attribute, rate);
  }

  // --- PÁGINA 3 ---
  void atualizarObstaculos(String index) {
    obstaculoVo.selectObstacle(index);
    notifyListeners();
  }

  // --- PÁGINA 4 ---
  void atualizarNome(String novoNome) {
    nomePico = novoNome;
    if(novoNome.isEmpty) errors = "Nome não pode ser vazio";
    notifyListeners();
  }

  void atualizarDescricao(String novoDesc) {
    descricao = novoDesc;
    if(novoDesc.isEmpty) errors = "Descrição não pode ser vazia";
    notifyListeners();
  }

  // --- IMAGENS ---
  Future<void> pickImages() async {
    try {
      await _pickImageUC.pick();
    } on Failure catch (e) {
      debugPrint("Erro ao selecionar imagens: $e");
      FailureServer.showError(e);
    }
    notifyListeners();
  }

  void removerImagens(int index) {
    files.removeAt(index);
    notifyListeners();
  }

  // --- CRIAÇÃO DO PICO ---
  Pico getInfoPico(UserIdentification? userCriador) {
    final utilitiesSelected = utilidadesSelecionadas.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    try {
      return PicoBuilder()
        .withId("") // backend vai gerar
        .withPicoName(nomePico)
        .withDescription(descricao)
        .withModalidade(ModalityVo(utilitiesSelected, selectedModalidade))
        .withLocation(locationVO)
        .withImgUrls(imgUrls)
        .withUser(userCriador)
        .withAttributesData(attributesVO.attributes) // VO mantém auto-validação
        .withTypeValue(typeSpotVo.selectedValue)
        .withObstacles(obstaculoVo.selectedValues)
        .withRating(RatingVo(0.0, 0))
        .withReviewers([])
        .withPosts([])
        .build();
    } on ArgumentError catch (e) {
      debugPrint("Erro ao criar spot: ${e.toString()}");
      rethrow;
    } on Failure catch (e) {
      debugPrint("Erro na contrução do spot: ${e.message}");
      rethrow;
    }
  }

  Future<void> createSpot(UserIdentification? user) async {
    try {
      final urls = await _uploadService.uploadFiles(files, "spots");
      imgUrls.addAll(urls);

      final picoEntity = getInfoPico(user);
      final picoModel = PicoModel.fromEntity(picoEntity);

      await _createSpotUc.createSpot(picoModel);

      limpar();
    } on Failure catch (e) {
      debugPrint("Erro ao criar pico: ${e.message}");
      FailureServer.showError(e);
    } on ArgumentError catch (e) {
      debugPrint("Erro ao criar spot: ${e.toString()}");
      rethrow;
    }
  }

  void limpar() {
    _pickImageUC.listFile.clear();
    imgUrls.clear();
    nomePico = '';
    descricao = '';
    selectedModalidade = ModalitySpot.skate;
    _updateConfig(selectedModalidade);
    notifyListeners();
  }

  @override
  void dispose() {
    limpar();
    super.dispose();
  }
}
