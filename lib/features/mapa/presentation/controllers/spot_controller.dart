import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/use%20cases/create_spot.dart';
import 'package:demopico/features/mapa/domain/use%20cases/show_all_pico.dart';
import 'package:demopico/features/mapa/presentation/widgets/marker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SpotControllerProvider extends ChangeNotifier {
  final CreateSpot createSpotUseCase;
  final ShowAllPico showAllPicoUseCase;

  Set<Marker> markers = {}; // Conjunto vazio de markers
  List<Pico> spots = [];
  List<Pico> picosPesquisados = [];
  Marker? markerEncontrado;

  SpotControllerProvider(this.createSpotUseCase, this.showAllPicoUseCase);

  // Método para criar um pico e adicionar o marker
  Future<void> createSpot(Pico pico, BuildContext context) async {
    try {
      // Gera o marker assíncrono
      final marker = await picoMarker(pico, context);
      markers.add(marker);
      notifyListeners();

      // Salva o pico no backend
      await createSpotUseCase.createSpot(pico);
    } catch (e) {
      print('Erro ao criar pico: $e');
    }
  }

  // Método para exibir todos os picos no mapa
  Future<void> showAllPico(BuildContext context) async {
    try {
      spots = await showAllPicoUseCase.executa();

      // Converte os picos em markers (processamento assíncrono)
      final markerFutures = spots.map((spot) => picoMarker(spot, context));
      markers = (await Future.wait(markerFutures)).toSet();

      notifyListeners();
    } catch (e) {
      print('Erro ao carregar markers: $e');
    }
  }

  // Método para pesquisar picos
  void pesquisandoPico(String word) {
    word = word.toLowerCase();
    picosPesquisados = spots
        .where((argument) =>
            argument.picoName.toLowerCase().contains(word.toLowerCase()))
        .toList();
    print("Ó os pico aq ó : $picosPesquisados");
    notifyListeners();
  }

  /*   Métodos para filtrar */
  List<Pico> picosFiltrados = [];
  String? tipoSelecionado;

  Future<void> filtrarPicosPorTipo(String? tipo, BuildContext context) async {
    tipoSelecionado = tipo;

    // Filtra os picos com base no tipo selecionado
    picosFiltrados = tipo == null
        ? spots // Exibe todos os spots se o tipo for nulo
        : spots.where((pico) => pico.tipoPico == tipo).toList();

    // Atualiza os markers com processamento assíncrono
    final markerFutures = picosFiltrados.map((pico) => picoMarker(pico, context));
    markers = (await Future.wait(markerFutures)).toSet();

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

  Future<void> filtrarPorUtilidade(BuildContext context) async {
    utilidadesSelecionadas = utilidadeFiltrar.entries
        .where((entry) => entry.value) // Filtra apenas as utilidades selecionadas
        .map((entry) => entry.key) // Pega o nome das utilidades
        .toList();

    if (utilidadesSelecionadas.isEmpty) {
      picosFiltrados = spots;
    } else {
      picosFiltrados = spots.where((pico) {
        return utilidadesSelecionadas
            .any((utilidade) => pico.utilidades?.contains(utilidade) ?? false);
      }).toList();
    }

    // Atualiza os markers com os picos filtrados
    final markerFutures = picosFiltrados.map((pico) => picoMarker(pico, context));
    markers = (await Future.wait(markerFutures)).toSet();

    notifyListeners();
  }

  void selecionarUtilidade(String utilidade, bool isSelected) {
    utilidadeFiltrar[utilidade] = isSelected;
    notifyListeners();
  }

  Future<void> filtrarModalidade(String? modalidade, BuildContext context) async {
    picosFiltrados = modalidade == null
        ? spots
        : spots.where((pico) => pico.modalidade == modalidade).toList();

    // Atualiza os markers com os picos filtrados
    final markerFutures = picosFiltrados.map((pico) => picoMarker(pico, context));
    markers = (await Future.wait(markerFutures)).toSet();

    notifyListeners();
  }
}
