
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:flutter/material.dart';

class  AddPicoControllerProvider extends ChangeNotifier {
  List<String> utilidades = [];
  Map<String, int> atributos = {};
  List<String> obstaculos = [];
  String nomePico = '';
  String descricao = '';
  String modalidade = 'Skate';
  double nota = 0.0;
  int numAval = 0;
  double lat = 0.0;
  double long = 0.0;

  late Pico pico;
  
  // notificar o estado de modalidade, tipo e utilidades
  void modalidadeTipoUtilidade(List<String> utilidades, String typeSpot, String modalidade){

  }

  // notificar o estado de atributos

  // notificar o estaddo de obstáculos 

  // notificar o estado de nome e descrição e anexar imagem

  


}