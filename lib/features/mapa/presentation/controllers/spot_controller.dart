
import 'package:demopico/features/mapa/domain/entities/filters.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/usecases/avaliar_spot_uc.dart';
import 'package:demopico/features/mapa/domain/usecases/create_spot_uc.dart';
import 'package:demopico/features/mapa/domain/usecases/load_spot_uc.dart';
import 'package:demopico/features/mapa/presentation/widgets/marker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SpotControllerProvider extends ChangeNotifier {
  final CreateSpotUc createSpotUseCase;
  final LoadSpotUc showAllPicoUseCase;
  final AvaliarSpotUc avaliarUseCase;

  Set<Marker> markers = {}; // Conjunto vazio de markers
  List<Pico> spots = [];
  List<Pico> picosPesquisados = [];
  List<Pico> myPicos = [];
  Marker? markerEncontrado;
  List<double> avaliacoes = [];
  final user = FirebaseAuth.instance.currentUser;
  bool isLoading = false;

  SpotControllerProvider(
      this.createSpotUseCase, this.showAllPicoUseCase, this.avaliarUseCase);

  // Método para criar um pico e adicionar o marker
  Future<void> createSpot(Pico pico, BuildContext context) async {
    try {
      // Salva o pico no backend
      final picoCriado = await createSpotUseCase.createSpot(pico as PicoModel);
      spots.add(picoCriado!);
      

      notifyListeners();
    } catch (e) {
      print('Erro ao criar pico: $e');
    }
  }


  // Método para exibir todos os picos no mapa
  Future<void> loadSpotsFromDB(BuildContext context, [Filters? filtro]) async {
    try {
      
      var picos =  showAllPicoUseCase.loadSpots(filtro);
      picos.listen((picos) {
        spots = picos;
        notifyListeners();
      });
      
      // Converte os picos em markers (processamento assíncrono)
      final markerFutures =  spots.map((spot) => picoMarker(spot, context));
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
