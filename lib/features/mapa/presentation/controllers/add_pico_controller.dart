
import 'dart:async';

import 'package:demopico/core/common/data/models/upload_file_model.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';
import 'package:demopico/features/mapa/domain/usecases/create_spot_uc.dart';
import 'package:demopico/core/common/usecases/pick_image_uc.dart';
import 'package:demopico/core/common/usecases/save_image_uc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddPicoProvider extends ChangeNotifier{
  static AddPicoProvider? _addPicoProvider;

  static AddPicoProvider get getInstance {
    _addPicoProvider ??= AddPicoProvider(
        pickImageUC: PickFileUC.getInstance,
        saveImageUC: SaveImageUC.getInstance,
        createSpotUc: CreateSpotUc.getInstance);
    return _addPicoProvider!;
  }

  //instanciando casos de uso
  final PickFileUC pickImageUC;
  final SaveImageUC saveImageUC;
  final CreateSpotUc createSpotUc;

  AddPicoProvider({required this.pickImageUC, required this.saveImageUC, required this.createSpotUc});

  Pico? pico;

  Map<String, int> atributos = {};
  List<String> obstaculos = [];
  String nomePico = '';
  String descricao = '';
  String selectedModalidade = 'Skate';
  double nota = 0.0;
  int numAval = 0;
  String tipo = 'Pico de Rua';
  List<String> utilidades = [];
  List<String> imgUrls = [];
  LatLng? latlang;

  String? errosImages;

  List<UploadFileModel> files = [];

  double progress = 0.0;

  void getLocation(LatLng latlang) {
    this.latlang = latlang;
  }
  

  Future<void> pickImages() async{
    try{
      files = await pickImageUC.pick();
    }on Exception catch(e) {
      debugPrint("Erro ao selecionar imagens: $e");
      errosImages = e.toString();
    }
    notifyListeners();
  }

  Future<void> uploadFiles() async{
    debugPrint("Iniciando upload de arquivos");
    final listResultFileModel = saveImageUC.saveImage(files);

    final urlFutures = <Future<String>>[];
    
    urlFutures.addAll(listResultFileModel.map((file) async => await file.url).toList());

    

    final urls = await Future.wait(urlFutures);
    debugPrint("URLs geradas do firestore: $urls");
    imgUrls.addAll(urls);
    debugPrint("URLs finais: $imgUrls");
    notifyListeners();
  }

  void removerImagens(int index){
    files.removeAt(index);
    notifyListeners();
  }
  

  
  /* - */

  //variaveis de mensagem de erro
  String? errors;

  Map<String, List<String>> utilidadesPorModalidade = {
    'Skate': [
      'Água',
      'Teto',
      'Banheiro',
      'Suave Arcadiar',
      'Público / Gratuito'
    ],
    'Parkour': ['Água', 'Banheiro', 'Mecânicas Próximas', 'Ar Livre'],
    'BMX': ['Água'],
  };

  List<String> utilidadesAtuais = [];
  Map<String, bool> utilidadesSelecionadas = {};

  void initialize() {
    // definindo o estado inicial de cada page
    _atualizarUtilidades();
    atributos = {
      'Chão': 2,
      'Iluminação': 3,
      'Policiamento': 5,
      'Movimento': 1,
      'Kick-Out': 4,
    };
  }
// notificar o estado de modalidade, tipo e utilidades
  void atualizarModalidade(String modalidade) {
    selectedModalidade = modalidade;
    _atualizarUtilidades();
    notifyListeners();
  }

  void atualizarDropdown(String novoValor) {
    tipo = novoValor;
    notifyListeners();
  }

  void selecionarUtilidade(String utilidade, bool isSelected) {
    utilidadesSelecionadas[utilidade] = isSelected;
    notifyListeners();
  }

  void _atualizarUtilidades() {
    utilidadesAtuais = utilidadesPorModalidade[selectedModalidade] ?? [];
    utilidadesSelecionadas.clear();
    for (var utilidade in utilidadesAtuais) {
      utilidadesSelecionadas[utilidade] = false;
    }
  }

  // notificar o estado de atributos
  void atualizarAtributo(String atributo, int value) {
    atributos[atributo] = value;
    notifyListeners();
  }

  // notificar o estaddo de obstáculos
  void atualizarObstaculos(String obstaculo) {
    obstaculos.add(obstaculo);
    notifyListeners();
  }

  //método pra remover dos selecionados
  void removerObstaculo(String obstaculo) {
    obstaculos.remove(obstaculo);
    notifyListeners();
  }

  // notificar o estado de nome e descrição
  void atualizarNome(String novoNome) {
    nomePico = novoNome;
    notifyListeners();
  }

  void atualizarDescricao(String novoDesc) {
    descricao = novoDesc;
    notifyListeners();
  }

  // validação
  bool validarAtributos() {
    return atributos.isNotEmpty &&
        atributos.values.every((value) => value >= 1);
  }

  bool validarObstaculos() {
    return obstaculos.isNotEmpty;
  }

  bool validarPagina1() {
    return utilidadesSelecionadas.values.contains(true);
  }

  // Função que valida tudo de uma vez
  bool validarPaginaAtual(int paginaAtual) {
    switch (paginaAtual) {
      case 0: // validação da primeira página
        return validarPagina1();
      case 1: // atributos
        return validarAtributos();
      case 2: // obstáculos
        return validarObstaculos();
      case 3:
        return validarFormulario();
      default:
        return true;
    }
  }

  bool validarTexto(){
    return nomePico.isNotEmpty && descricao.isNotEmpty;
  }

  bool validarFormulario() {
    final camposValidos = validarTexto();
    final validarImagens = files.isNotEmpty;
    return camposValidos && validarImagens;
  }
  
  

  PicoModel getInfoPico(String? userCriador) {
    return PicoModel(
      id: "",
      picoName: nomePico,
      description: descricao,
      nota: nota,
      numeroAvaliacoes: numAval,
      tipoPico: tipo,
      utilidades: utilidades,
      imgUrls: imgUrls,
      lat: latlang!.latitude,
      long: latlang!.longitude,
      atributos: atributos,
      modalidade: selectedModalidade,
      userCreator: userCriador ?? "Anônimo",
      obstaculos: obstaculos,
    );
  }

  void limpar() {
    atributos.clear();
    obstaculos.clear();
    nomePico = '';
    descricao = '';
    selectedModalidade = 'Skate';
    nota = 0.0;
    numAval = 0;
    imgUrls.clear();
    tipo = 'Pico de Rua';
    utilidades.clear();
    files.clear();
    notifyListeners();
  }
   

  String? errorCriarPico;

  Future<void> createSpot(String? user) async {
    try {
      late PicoModel newPico;
      // Faz o upload das imagens e espera as urls
      await uploadFiles().then((_) => newPico = getInfoPico(user));


      // Salva o pico no backend
      
      await createSpotUc.createSpot(newPico);
      
      // Limpa os campos após a criação bem-sucedida
      limpar();
    }on Failure catch (e) {
      errorCriarPico = e.message;
    }
  }

  @override
  void dispose() {
    super.dispose();
    limpar();
  }
}
