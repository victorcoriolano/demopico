import 'dart:async';

import 'package:demopico/features/mapa/domain/entities/filters.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/usecases/avaliar_spot_uc.dart';
import 'package:demopico/features/mapa/domain/usecases/create_spot_uc.dart';
import 'package:demopico/features/mapa/domain/usecases/load_spot_uc.dart';
import 'package:flutter/material.dart';

class SpotControllerProvider extends ChangeNotifier {
  static SpotControllerProvider? _spotControllerProvider;
  static SpotControllerProvider get getInstance {
    _spotControllerProvider ??= SpotControllerProvider(
        createSpotUseCase: CreateSpotUc.getInstance,
        avaliarUseCase: AvaliarSpotUc.getInstance,
        showAllPicoUseCase: LoadSpotUc.getInstance);
    return _spotControllerProvider!;
  }

  SpotControllerProvider(
      {required this.createSpotUseCase,
      required this.avaliarUseCase,
      required this.showAllPicoUseCase});

  final CreateSpotUc createSpotUseCase;
  final LoadSpotUc showAllPicoUseCase;
  final AvaliarSpotUc avaliarUseCase;

  List<Pico> spots = [];
  List<Pico> picosPesquisados = [];
  List<Pico> myPicos = [];
  Filters? filtrosAtivos;

  StreamSubscription? spotsSubscription;

  //inicializa o controller carregando os spots do banco
  void initialize() {
    _loadSpots();
  }

  //cria um stream para ouvir os spots do banco de dados
  void _loadSpots() {
    spotsSubscription?.cancel();
    spotsSubscription =
        showAllPicoUseCase.loadSpots(filtrosAtivos).listen((spots) {
      myPicos = spots;
      notifyListeners();
    });
  }

  //aplica os filtros e reacria o stream com os novos filtros
  void aplicarFiltro([Filters? filtros]) {
    filtrosAtivos = filtros;
    _loadSpots();
  }

  //cancela a subscription da stream
  @override
  void dispose() {
    spotsSubscription?.cancel();
    super.dispose();
  }

  // Método para criar um pico e adicionar o marker
  Future<void> createSpot(Pico pico) async {
    try {
      // Salva o pico no backend
      final picoCriado = await createSpotUseCase.createSpot(pico as PicoModel);
      spots.add(picoCriado!);

      notifyListeners();
    } catch (e) {
      throw Exception("Erro ao criar o pico: $e");
    }
  }

  // Método para pesquisar picos
  void pesquisandoPico(String word) {
    word = word.toLowerCase();
    picosPesquisados = spots
        .where((argument) =>
            argument.picoName.toLowerCase().contains(word.toLowerCase()))
        .toList();
    notifyListeners();
  }

  List<String> utilidades = [
    'Água',
    'Teto',
    'Banheiro',
    'Suave Arcadiar',
    'Público / Gratuito'
  ];

  Map<String, bool> utilidadeFiltrar = {
    'Água': false,
    'Teto': false,
    'Banheiro': false,
    'Suave Arcadiar': false,
    'Público / Gratuito': false
  };
  List<String> utilidadesSelecionadas = [];

  void selecionarUtilidade(String utilidade, bool? isSelected) {
    utilidadeFiltrar[utilidade] = isSelected!;
    notifyListeners();
  }

  //método avaliar pico
  Future<void> avaliarPico(Pico pico, double novaNota) async {
    try {
      // Use case para avaliar e obter o pico atualizado
      final picoAtualizado =
          await avaliarUseCase.executar(novaNota, pico as PicoModel);

      // Encontrar o índice do pico a ser atualizado
      final index =
          spots.indexWhere((picos) => picos.picoName == pico.picoName);

      // Atualizar o pico na lista
      spots[index] = picoAtualizado;
      notifyListeners();
    } catch (e) {
      throw Exception("Erro ao avaliar o pico: $e");
    }
  }
}
