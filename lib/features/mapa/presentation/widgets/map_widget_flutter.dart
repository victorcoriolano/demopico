import 'dart:async';

import 'package:demopico/features/mapa/presentation/controllers/flutter_map_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/spots_controller.dart';
import 'package:demopico/features/mapa/presentation/view_services/marker_service_flutter.dart';
import 'package:demopico/features/mapa/presentation/view_services/modal_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

class MapWidgetFlutter extends StatefulWidget {
  const MapWidgetFlutter({
    super.key,
  });

  @override
  MapWidgetFlutterState createState() => MapWidgetFlutterState();
}

class MapWidgetFlutterState extends State<MapWidgetFlutter> {
  late SpotControllerProvider _spotControllerProvider;
  late FlutterMapControllerProvider _mapControllerProvider;

  @override
  void initState() {
    super.initState();
    _spotControllerProvider = context.read<SpotControllerProvider>();
    _mapControllerProvider = context.read<FlutterMapControllerProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      _initializeProviders();  
    });
  }

  Future<void> _initializeProviders() async {
    _spotControllerProvider.setOnTapMarker(
      (pico) => ModalHelper.openModalInfoPico(context, pico),
    );
    _spotControllerProvider.initialize();
  }

  @override
  Widget build(BuildContext context) {
    
    // consome os dados do provider para manter a tela atualizada
    return Scaffold(
      body: Consumer2<SpotControllerProvider, FlutterMapControllerProvider>(
        builder: (context, provider, mapProvider, child) => FlutterMap(
          options: MapOptions(
            initialCenter: mapProvider.center,
            initialZoom: 15.5,  
          ),
          mapController: mapProvider.mapController,
          children: [
            TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                  
              ),
            MarkerLayer(
              markers: MarkerServiceFlutter.getInstance.markers,
              alignment: Alignment.center,
              
            ),
          ],
        ),
      ),
    );
  }
}