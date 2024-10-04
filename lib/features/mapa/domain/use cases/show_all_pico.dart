import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/spot_repository.dart';
import 'package:demopico/features/mapa/presentation/widgets/show_pico_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowAllPico {
  final SpotRepository spotRepository;
  ShowAllPico(this.spotRepository);


  Future<List<Marker>> execute(BuildContext context) async {
    // pegando o spot do banco de dados e transformando em um marker
    try {
      List<Pico> spots = await spotRepository.showAllPico();
      return spots.map((spot) {
        return Marker(
          markerId: MarkerId(spot.urlIdPico),
          position: LatLng(spot.lat!, spot.long!),
       onTap: () => _showPicoModal(context, spot),
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


void _showPicoModal(BuildContext context, Pico pico) {
  print('Chamando modal para: ${pico.picoName}'); // Adicione isto para depuração
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(pico.picoName),
        content: ShowPicoWidget(pico: pico),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Fechar'),
          ),
        ],
      );
    },
  );
}


}