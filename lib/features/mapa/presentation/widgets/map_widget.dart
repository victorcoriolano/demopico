import 'dart:async';

import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_controller.dart';
import 'package:demopico/features/mapa/presentation/view_services/modal_helper.dart';
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
    _spotControllerProvider.setOnTapMarker(
      (pico) => ModalHelper.openModalInfoPico(context, pico),
    );
    _spotControllerProvider.initialize();
  }
  



  @override
  Widget build(BuildContext context) {
    
    // consome os dados do provider para manter a tela atualizada
    return Scaffold(
      body: Consumer<SpotControllerProvider>(
        builder: (context, provider, child) => GoogleMap(
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
          markers: provider.markers,
          onLongPress: (latlang) => ModalHelper.openAddPicoModal(context, latlang),
        ),
      ),
    );
  }
}