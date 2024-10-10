
import 'package:demopico/features/user/presentation/widgets/validator.dart';
import 'package:flutter/material.dart';

class  AddPicoControllerProvider extends ChangeNotifier with Validators {
  Map<String, int> atributos = {};
  List<String> obstaculos = [];
  String nomePico = '';
  String descricao = '';
  String selectedModalidade = 'Skate';
  double nota = 0.0;
  int numAval = 0;
  String tipo = 'Pico de Rua';

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

  /* bool validarPrimeiraPágina(){
    return true;
  } */

  


}