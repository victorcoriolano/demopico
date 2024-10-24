import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/use%20cases/create_spot.dart';
import 'package:demopico/features/mapa/domain/use%20cases/show_all_pico.dart';
import 'package:demopico/features/mapa/presentation/widgets/marker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SpotControllerProvider extends ChangeNotifier{

  final CreateSpot createSpotUseCase;
  final ShowAllPico showAllPicoUseCase;
  
  Set<Marker> markers = {};//lista vazia de markers para adicionar os picos 

  SpotControllerProvider(this.createSpotUseCase, this.showAllPicoUseCase);
  

  //método para chamar o caso de uso criar pico que irá execultar a lógica de criar o pico
  Future<void> createSpot(Pico pico, BuildContext context) async {
    final marker = picoMarker(pico, context);
    markers.add(marker);
    try{
      await createSpotUseCase.createSpot(pico);
    } catch (e){
      print('Erro ao criar pico: $e');
    }
    //chama a função de apresentar pico para atualizar a tela com o novo pico 
  }

  Future<Set<Marker>> turnsPicoToMarker(BuildContext context) async {
    // pegando o spot do use case e transformando em um marker
    try {
      List<Pico> spots = await showAllPicoUseCase.executa();
      print(spots);
      return spots.map((spot) {
        return picoMarker(spot, context); // marker separado 
      }).toSet();
    } on Exception catch (e) {
      print('Erro ao buscar spots: $e');
      return {};
    }
  }

  //método de mostrar os picos a partir dos picos salvos no bd 
  Future<void> showAllPico(BuildContext context) async {
    try {
      final Set<Marker> spots = await turnsPicoToMarker(context);
      markers.addAll(spots); // adiciona os spots ao markers 
    } on Exception catch (e) {
      print('Erro ao carregar markers: $e');
    }
  }


}
