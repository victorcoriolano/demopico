import 'dart:async';

import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/spots_controller.dart';
import 'package:demopico/features/mapa/presentation/view_services/modal_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  late SpotsControllerProvider _spotControllerProvider;
  late MapControllerProvider _mapControllerProvider;

  @override
  void initState() {
    super.initState();
    _spotControllerProvider = context.read<SpotsControllerProvider>();
    _mapControllerProvider = context.read<MapControllerProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeProviders();
    });
  }

  Future<void> _initializeProviders() async {
    await _mapControllerProvider.getLocation();
    _spotControllerProvider.setOnTapMarker(
      (pico) => ModalHelper.openModalInfoPico(context, pico),
    );
    _spotControllerProvider.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final LatLng? location = Get.arguments as LatLng?;

    // consome os dados do provider para manter a tela atualizada
    return Scaffold(
      body: Consumer2<SpotsControllerProvider, MapControllerProvider>(
        builder: (context, provider, mapProvider, child) => GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _mapControllerProvider.setGoogleMapController(controller);
          },
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
            target: location ?? mapProvider.center,
            zoom: mapProvider.zoomInicial,
          ),
          mapType: mapProvider.myMapType,
          scrollGesturesEnabled: true,
          rotateGesturesEnabled: true,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          tiltGesturesEnabled: true,
          markers: provider.markers,
          onLongPress: (latlang) => ModalHelper.openAddPicoModal(context, latlang),

/*           onLongPress: (latlang) {
            _mapControllerProvider.reajustarCameraPosition(latlang);
            _mapControllerProvider.setZoom(15);
            provider.markers.add(Marker(
                markerId: MarkerId('Criar Novo Pico Aqui'),
                infoWindow: InfoWindow(
                  title: "Deseja criar um novo spot nesse lugar?",
                  onTap: () => Get.toNamed(""),
                )));
          },
 */        ),
      ),
    );
  }
}
