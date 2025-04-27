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

    late SpotControllerProvider _spotControllerProvider;
    late MapControllerProvider _mapControllerProvider;



    @override
    void initState() {
      super.initState();
      _spotControllerProvider = context.read<SpotControllerProvider>();
      _mapControllerProvider = context.read<MapControllerProvider>();
      _initializeProviders();
    }

    Future<void> _initializeProviders() async {
      await _mapControllerProvider.getLocation();
      _spotControllerProvider.initialize();
      await _mapControllerProvider.loadMarkersIcons(_spotControllerProvider.spots);
    }
  
    @override
    Widget build(BuildContext context) {
      // consome os dados do provider para manter a tela atualizada
      return Scaffold(
        body:  Consumer<SpotControllerProvider>(
          builder: (context, provider, child)  =>  GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  _mapControllerProvider.setGoogleMapController(controller);
                },
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: _mapControllerProvider.center,
                  zoom: _mapControllerProvider.zoomInicial,
                ),
                mapType: _mapControllerProvider.myMapType,
                scrollGesturesEnabled: true,
                rotateGesturesEnabled: true,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                tiltGesturesEnabled: true,
                markers: _mapControllerProvider.markers,
                onLongPress: (latlang) => showModalAddPico(context, latlang),
              ),
        ),
            );
  }   
}

void showModalAddPico ( BuildContext context, LatLng latLng) {
   showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.868, // Define a altura do modal
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        ContainerTelas(
                          expanded: false,
                          latlang: latLng,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: IconButton(
                            icon: const Icon(Icons.close,
                                color: Color.fromARGB(255, 0, 0, 0)),
                            iconSize: 36, // Cor branca para o botão "X"
                            onPressed: () {
                                Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
}    
    
