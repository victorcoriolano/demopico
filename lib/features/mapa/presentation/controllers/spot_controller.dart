import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/use%20cases/create_spot.dart';
import 'package:demopico/features/mapa/domain/use%20cases/show_all_pico.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SpotController {
  final CreateSpot createSpotUseCase;
  final ShowAllPico showAllPicoUseCase;
  
  Set<Marker> markers = {};//lista vazia de markers para adicionar os picos 

  SpotController(this.createSpotUseCase, this.showAllPicoUseCase);

  //método para chamar o caso de uso criar pico que irá execultar a lógica de criar o pico
  Future<void> createSpot(Pico pico, BuildContext context) async {
    try{
      await createSpotUseCase.createSpot(pico);
    } catch (e){
      print('Erro ao criar pico: $e');
    }
    //chama a função de apresentar pico para atualizar a tela com o novo pico 
    showAllPico(context);
  }

  //método de mostrar os picos a partir dos picos salvos no bd 
Future<void> showAllPico(BuildContext context) async {
  try {
    List<Marker> spotMarkers = await showAllPicoUseCase.execute(context);
    markers = spotMarkers.toSet(); // Converte a lista de markers para um Set
  } catch (e) {
    print('Erro ao carregar markers: $e');
  }
}

}
