
import 'dart:io';

import 'package:demopico/features/user/presentation/widgets/validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class  AddPicoControllerProvider extends ChangeNotifier with Validators {
  Map<String, int> atributos = {};
  List<String> obstaculos = [];
  String nomePico = '';
  String descricao = '';
  String selectedModalidade = 'Skate';
  double nota = 0.0;
  int numAval = 0;
  String tipo = 'Pico de Rua';
  List<String> utilidades = [];
  String urlImage = '';
  File? fotoPico;
  double lat = 0.0;
  double long = 0.0;

  final pegadorImage = ImagePicker();

  Future<void> selecionarImag() async {
    try {
      //tenta pegar imgem da galeria 
      final img = await pegadorImage.pickImage(source: ImageSource.gallery);

      if(img != null){
        // chamar o método para subir o pico no firebase 
        //fotoPico = File(img.path);
        testeSubindoImg(File(img.path)) ;
      }
    }on Exception catch (e) {
      print("Erro ao subir imagem $e");
    }
  }
  //teste teste test teste teste teste teste teste 
  Future<void> testeSubindoImg(File? img) async {
    try{
      final ref = FirebaseStorage.instance
          .ref()
          .child('spots_images')
          .child('images/$nomePico.jpg');
      await ref.putFile(img!);
      urlImage = await ref.getDownloadURL();
    }on Exception catch (e){
      print("Erro ao subir por storage: $e");
    }
  }
  
  void atualizarLocalizacao(LatLng localizacao){
    lat = localizacao.latitude;
    long = localizacao.longitude;
  }


  //variaveis de mensagem de erro 
  String? nomePicoErro;
  String? descricaoErro;

  Map<String, List<String>> utilidadesPorModalidade = {
    'Skate': ['Água', 'Teto', 'Banheiro', 'Suave f1', 'Público / Gratuito'],
    'Parkour': ['Água', 'Banheiro', 'Mecânicas Próximas', 'Ar Livre'],
    'BMX': ['Água'],
  };

  List<String> utilidadesAtuais = [];
  Map<String, bool> utilidadesSelecionadas = {};

  
  AddPicoControllerProvider() {
    // definindo o estado inicial de cada page
    _atualizarUtilidades();
    atributos  = {
      'Chão': 4,
      'Iluminação': 3,
      'Policiamento': 4,
      'Movimento': 3,
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
  void atualizarAtributo(String atributo, int value){
    atributos[atributo] = value;

    notifyListeners();
  }
  

  // notificar o estaddo de obstáculos 
  void atualizarObstaculos(String obstaculo){
    obstaculos.add(obstaculo);
    notifyListeners();
  }
  //método pra remover dos selecionados
  void removerObstaculo(String obstaculo) {
    obstaculos.remove(obstaculo);
    notifyListeners();
  }

  // notificar o estado de nome e descrição 
  void atualizarNome(String novoNome){
    nomePico = novoNome;
    notifyListeners();
  }
  void atualizarDescricao(String novoDesc){
    descricao = novoDesc;
    notifyListeners();
  }

  // validação 
  bool validarAtributos() {
    return atributos.isNotEmpty && atributos.values.every((value) => value >= 1);
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
    return nomeValido && descricaoValida;
  }

  


}