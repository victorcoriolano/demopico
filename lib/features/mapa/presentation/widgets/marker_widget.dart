
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/presentation/widgets/show_pico_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//marker separado da lógica

Marker picoMarker(Pico spot, BuildContext context){
  return Marker(
    markerId: MarkerId(spot.urlIdPico),
    position: LatLng(spot.lat!, spot.long!),
    onTap: () => _showPicoModal(context, spot),
    infoWindow: InfoWindow(
      title: spot.picoName,
      snippet: spot.description,
    ),
  );
}

void _showPicoModal(BuildContext context, Pico pico) {
  print('Chamando modal para: ${pico.picoName}'); // Adicione isto para depuração
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return ShowPicoWidget(pico: pico); // Exibe seu widget aqui
    },
  );
}