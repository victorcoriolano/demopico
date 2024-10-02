import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/use%20cases/create_spot.dart';
import 'package:demopico/features/mapa/domain/use%20cases/show_all_pico.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SpotController {
  final CreateSpot createSpotUseCase;
  final ShowAllPico showAllPicoUseCase;
  
  Set<Marker> markers = {};//lista vazia de markers para adicionar os picos 

  SpotController(this.createSpotUseCase, this.showAllPicoUseCase);

  //método para chamar o caso de uso criar pico que irá execultar a lógica de criar o pico
  Future<void> createSpot(Pico pico) async {
    createSpotUseCase.createSpot(pico);
    //sem nenhum tratamento de erro pq nois eh ruim 
  }

  //método de mostrar os picos a partir dos picos salvos no bd 
  Future<Set<Marker>> showAllPico()  async {
    await showAllPicoUseCase.execute().then((spotInList) => markers.addAll(spotInList));
    return markers;
  }
}
