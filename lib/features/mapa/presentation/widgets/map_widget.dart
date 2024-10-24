import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_controller.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_modal/container_telas.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({
    super.key,
  });

  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {

  @override
  Widget build(BuildContext context) {
    final spotProvider = Provider.of<SpotControllerProvider>(context, listen: true);
    final mapProvider = Provider.of<MapControllerProvider>(context, listen: true);
    // consome os dados do provider para manter a tela atualizada
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) async {
      mapProvider.setGoogleMapController(controller);
      await spotProvider.showAllPico(context);
      await mapProvider.getLocation();
              
      print(mapProvider.center);
      print(mapProvider.locationMessage);
      },
      zoomControlsEnabled: true,
      initialCameraPosition: CameraPosition(
        target: mapProvider.center,
        zoom: 15.0,
      ),
      scrollGesturesEnabled: true,
      rotateGesturesEnabled: true,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      tiltGesturesEnabled: true,
      markers: spotProvider.markers,
      onLongPress: (argument) => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) =>  SizedBox(
          height: MediaQuery.of(context).size.height * 0.868, // Define a altura do modal
          child: Stack(
          alignment: Alignment.topRight,
          children: [
            ContainerTelas(
              expanded: false,
              lat: argument.latitude,
              long: argument.longitude,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Color.fromARGB(255, 0, 0, 0)),
                  iconSize: 36, // Cor branca para o botão "X"
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
