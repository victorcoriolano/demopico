
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/presentation/controllers/historico_controller.dart';
import 'package:demopico/features/mapa/presentation/widgets/map_widget.dart';
import 'package:demopico/features/mapa/presentation/widgets/show_pico_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

//marker separado da lógica

Future<Marker> picoMarker(Pico? spot, BuildContext context, ) async {
/*     if (spot != null) { */
  return Marker(
  markerId: MarkerId(spot!.picoName),
  position: LatLng(spot.lat, spot.long),
  onTap: () {
    final contextCerto = scaffoldKey.currentContext;
    if(contextCerto != null){
      showPicoModal(contextCerto, spot);
    }else {
      print("Context errado: $contextCerto");
    }

  },
  icon: await const TextOnImage(
    text: '',
    ).toBitmapDescriptor(
      logicalSize: const Size(150, 150), imageSize: const Size(120, 150)
    ),
    );
}

void showPicoModal(BuildContext context, Pico pico) {
  print('Chamando modal para: ${pico.picoName}');
  print('Imagem url: ${pico.imgUrls}');
  print("Contexto: $context");
  // salvando no histórico 
  final provider = context.read<HistoricoController>();
  provider.salvarNoHistorico(pico.picoName, pico.lat, pico.long);

  try {
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
}  catch (e) {
  // TODO
  print("Erro ao mostrar o botton sheet: $e ");
}
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
          height: 350,
          width: 350,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.black),
        )
      ],
    );
  }
}


