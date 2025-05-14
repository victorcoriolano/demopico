import 'dart:io';

import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/usecases/pick_image_uc.dart';
import 'package:demopico/features/mapa/domain/usecases/save_image_uc.dart';
import 'package:demopico/features/user/presentation/widgets/form_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddPicoProvider extends ChangeNotifier with Validators {
  static AddPicoProvider? _addPicoProvider;

  static AddPicoProvider get getInstance {
    _addPicoProvider ??= AddPicoProvider(
        pickImageUC: PickImageUC.getInstance,
        saveImageUC: SaveImageUC.getInstance);
    return _addPicoProvider!;
  }

  //instanciando casos de uso
  final PickImageUC pickImageUC;
  final SaveImageUC saveImageUC;

  AddPicoProvider({required this.pickImageUC, required this.saveImageUC});

  bool loadingImagens = false;
  Map<String, int> atributos = {};
  List<String> obstaculos = [];
  String nomePico = '';
  String descricao = '';
  String selectedModalidade = 'Skate';
  double nota = 0.0;
  int numAval = 0;
  String tipo = 'Pico de Rua';
  List<String> utilidades = [];
  List<String> urlImage = [];
  File? fotoPico;
  LatLng? latlang;
  List<File?> images = [];

  final pegadorImage = ImagePicker();

  Future<void> selecionarImag() async {
    images.clear();
    urlImage.clear();
    try {
      // Reseta a lista de imagens antes de selecionar novas

      // Pega múltiplas imagens da galeria (limite de 3)
      final imgs = await pegadorImage.pickMultiImage(
        limit: 3,
      );
      if (imgs.isNotEmpty) {
        for (var img in imgs) {
          images.add(File(img.path));
        }
        // Chama o método para subir as imagens

        await testeSubindoImg(images);
      }
    } on Exception catch (e) {
      debugPrint('Erro ao selecionar imagem: $e');
      throw Exception('Erro ao selecionar imagem: $e');
    }
  }

  Future<void> testeSubindoImg(List<File?> imgs) async {
    try {
      for (var img in imgs) {
        // Gera um nome único para cada imagem
        final uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
        final ref = FirebaseStorage.instance
            .ref()
            .child('spots_images')
            .child('images/$nomePico$uniqueName.jpg');

        debugPrint('Enviando imagem: ${img!.path}');

        // Faz o upload da imagem
        await ref.putFile(img);

        // Adiciona a URL de download à lista
        final downloadURL = await ref.getDownloadURL();
        urlImage.add(downloadURL);
      }

      urlImage.clear;
    } on Exception catch (e) {
      throw Exception('Erro ao subir imagem: $e');
    }
  }

  void pegarLocalizacao(LatLng localizacao) {
    latlang = localizacao;
  }

  //variaveis de mensagem de erro
  String? nomePicoErro;
  String? descricaoErro;

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

  addPicoControllerProvider() {
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

  bool imagensIsNotEmpty() {
    return urlImage.isNotEmpty;
  }

  bool validarNomePico() {
    if (nomePico.isEmpty) {
      nomePicoErro = "Preencha este campo";
      notifyListeners();
      return false;
    }
    nomePicoErro = null;
    notifyListeners();
    return true;
  }

  bool validarDescricao() {
    if (descricao.isEmpty) {
      descricaoErro = "Preencha este campo";
      notifyListeners();
      return false;
    }
    descricaoErro = null;
    notifyListeners();
    return true;
  }

  bool validarFormulario() {
    final nomeValido = validarNomePico();
    final descricaoValida = validarDescricao();
    final validarImagens = imagensIsNotEmpty();
    return nomeValido && descricaoValida && validarImagens;
  }

  void limpar() {
    atributos.clear();
    obstaculos.clear();
    nomePico = '';
    descricao = '';
    selectedModalidade = 'Skate';
    nota = 0.0;
    numAval = 0;
    tipo = 'Pico de Rua';
    utilidades.clear();
    urlImage.clear();
    notifyListeners();
  }

  Pico getInfoPico(User? userCriador) {
    return Pico(
      id: "",
      picoName: nomePico,
      description: descricao,
      nota: nota,
      numeroAvaliacoes: numAval,
      tipoPico: tipo,
      utilidades: utilidades,
      imgUrls: urlImage,
      lat: latlang!.latitude,
      long: latlang!.longitude,
      atributos: atributos,
      modalidade: selectedModalidade,
      userCreator: userCriador?.displayName ?? "Anônimo",
      obstaculos: obstaculos,
    );
  }
}
