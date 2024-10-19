
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/presentation/widgets/show_pico_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//marker separado da lógica

Marker picoMarker(Pico spot, BuildContext context){
    return Marker(
    markerId: MarkerId(spot.picoName),
    position: LatLng(spot.lat, spot.long),
    onTap: () => _showPicoModal(context, spot),
    infoWindow: InfoWindow(
      title: spot.picoName,
      snippet: spot.tipoPico,
    ),
  );
}

void _showPicoModal(BuildContext context, Pico pico) {
  print('Chamando modal para: ${pico.picoName}');
  print('Imagem url: ${pico.imgUrl}');

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent, // Transparência para o fundo
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.4, 
        minChildSize: 0.2, 
        maxChildSize: 0.86, 
        builder: (BuildContext context, ScrollController scrollController) {
          return ShowPicoWidget(pico: pico, scrollController: scrollController);
        },
      );
    },
  );
}
