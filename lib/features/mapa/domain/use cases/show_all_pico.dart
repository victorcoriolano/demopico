import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/spot_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowAllPico {
  final SpotRepository spotRepository;
  ShowAllPico(this.spotRepository);


  Future<List<Marker>> execute() async {
    // pegando o spot do banco de dados e transformando em um marker
    try {
      List<Pico> spots = await spotRepository.showAllPico();
      return spots.map((spot) {
        return Marker(
          markerId: MarkerId(spot.picoName!),
          position: LatLng(spot.lat!, spot.long!),
          infoWindow: InfoWindow(
            title: spot.picoName,
            snippet: spot.description,
          ),
        );
      }).toList();
    } catch (e) {
      print('Erro ao buscar spots: $e');
      return [];
    }
  }

}