
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/presentation/widgets/show_pico_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

//marker separado da lógica

Future<Marker> picoMarker(Pico spot, BuildContext context, ) async {
    return Marker(
    markerId: MarkerId(spot.picoName),
    position: LatLng(spot.lat, spot.long),
    onTap: () => showPicoModal(context, spot),
    infoWindow: InfoWindow(
      title: spot.picoName,
      snippet: spot.tipoPico,
    ),
    icon: await TextOnImage(
        text: "Hello World",
      ).toBitmapDescriptor(
         logicalSize: const Size(150, 150), imageSize: const Size(150, 150)
      ),
  );
}

void showPicoModal(BuildContext context, Pico pico) {
  print('Chamando modal para: ${pico.picoName}');
  print('Imagem url: ${pico.imgUrl}');
  
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent, // Transparência para o fundo
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.6, 
        minChildSize: 0.2, 
        maxChildSize: 0.86, 
        builder: (BuildContext context, ScrollController scrollController) {
          return ShowPicoWidget(pico: pico, scrollController: scrollController);
        },
      );
    },
  );
}
class TextOnImage extends StatelessWidget {
  const TextOnImage({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Image(
          image: AssetImage(
            "assets/images/Location.png",
          ),
          height: 150,
          width: 150,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.black),
        )
      ],
    );
  }
}
