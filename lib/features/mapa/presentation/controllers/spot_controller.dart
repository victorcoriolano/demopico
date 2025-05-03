import 'package:demopico/features/mapa/data/models/pico_model.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/usecases/avaliar_spot_uc.dart';
import 'package:demopico/features/mapa/domain/usecases/create_spot_uc.dart';
import 'package:demopico/features/mapa/domain/usecases/list_spot_uc.dart';
import 'package:demopico/features/mapa/presentation/widgets/marker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SpotControllerProvider extends ChangeNotifier {
  final CreateSpotUc createSpotUseCase;
  final ListSpotUc showAllPicoUseCase;
  final AvaliarSpotUc avaliarUseCase;

  Set<Marker> markers = {}; // Conjunto vazio de markers
  List<Pico> spots = [];
  List<Pico> picosPesquisados = [];
  List<Pico> myPicos = [];
  Marker? markerEncontrado;
  List<double> avaliacoes = [];
  final user = FirebaseAuth.instance.currentUser;

  SpotControllerProvider(
      this.createSpotUseCase, this.showAllPicoUseCase, this.avaliarUseCase);

  // Método para criar um pico e adicionar o marker
  Future<void> createSpot(Pico pico, BuildContext context) async {
    try {


      // Salva o pico no backend
      await createSpotUseCase.createSpot(pico as PicoModel);
      if(context.mounted){
        await showAllPico(context).whenComplete(() => print("Pico postado"));
        
      }
      

      notifyListeners();
    } catch (e) {
      print('Erro ao criar pico: $e');
    }
  }

  // Método para exibir todos os picos no mapa
  Future<void> showAllPico(BuildContext context) async {
    try {
      spots = await showAllPicoUseCase.executa();
      if(user != null){
        myPicos = spots.where((pico) => pico.userCreator == user!.displayName).toList();
        print(myPicos);
        
      }

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

  Future<void> filtrarPicosPorTipo(String? tipo, BuildContext context) async {
    print(tipo);
    print("Lista de spots antes da filtragem: $spots");

    // Filtra os picos com base no tipo selecionado
    if (tipo == 'todos') {
      picosFiltrados.clear();
      picosFiltrados = spots;
      print("Picos filtrados: $picosFiltrados");
      
    } else {
      picosFiltrados.clear();
      picosFiltrados
          .addAll(spots.where((pico) => pico.tipoPico == tipo).toList());
      print("Picos filtrados: $picosFiltrados");
      
    }

    // Atualiza os markers com processamento assíncrono
    markers.clear();
    final markerFutures = picosFiltrados.map((pico) => picoMarker(pico, context));
    markers = (await Future.wait(markerFutures)).toSet();
    print(markers.firstOrNull ?? "Nwnhum marker encontrado");

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
        .where(
            (entry) => entry.value) // Filtra apenas as utilidades selecionadas
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
        markers.clear();
    final markerFutures = picosFiltrados.map((pico) => picoMarker(pico, context));
    markers = (await Future.wait(markerFutures)).toSet();
    print(markers.firstOrNull ?? "Nwnhum marker encontrado");

    notifyListeners();
  }

  void selecionarUtilidade(String utilidade, bool? isSelected) {
    utilidadeFiltrar[utilidade] = isSelected!;
    notifyListeners();
  }

  Future<void> filtrarModalidade(
      String? modalidade, BuildContext context) async {
    if (modalidade == null || modalidade.isEmpty) {
      print("Modalidade não definida, mostrando todos.");
      picosFiltrados = spots;
    } else {
      picosFiltrados =
          spots.where((pico) => pico.modalidade == modalidade).toList();

      // Atualiza os markers com os picos filtrados
          markers.clear();
    final markerFutures = picosFiltrados.map((pico) => picoMarker(pico, context));
    markers = (await Future.wait(markerFutures)).toSet();
    print(markers.firstOrNull ?? "Nenhum marker encontrado");

    notifyListeners();
    }
  }

  //método avaliar pico
  Future<void> avaliarPico(Pico pico, double novaNota) async {
    try {
      // Use case para avaliar e obter o pico atualizado
      final picoAtualizado = await avaliarUseCase.executar(novaNota, pico as PicoModel);

      // Encontrar o índice do pico a ser atualizado
      final index =
          spots.indexWhere((picos) => picos.picoName == pico.picoName);

      if (index != -1) {
        spots[index] = picoAtualizado;
        notifyListeners();
      } else {
        print("Pico não encontrado na lista.");
      }
    } catch (e) {
      print("Erro ao salvar a avaliação: $e");
    }
  }
  

}
