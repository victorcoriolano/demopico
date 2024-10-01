import 'package:demopico/features/mapa/data/services/maps_service_singleton.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../domain/entities/pico_entity.dart'; // Importa o permission_handler

class MapWidget extends StatefulWidget {
  const MapWidget({super.key, required List<Pico> markers, });

  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  
  String _locationMessage = "Aguardando localização...";
  late GoogleMapController mapController;
  LatLng _center = const LatLng(0, 0);
  // Inicializa o centro do mapa

  // Função para verificar permissões
  Future<bool> _handleLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      // Solicita permissão
      status = await Permission.location.request();
      if (!status.isGranted) {
        // Se o usuário negar a permissão, exibe uma mensagem
        setState(() {
          _locationMessage = "Permissão de localização negada.";
        });
        return false;
      }
    }
    return true;
  }

  // Função para obter a localização
  Future<void> _getLocation() async {
    bool permissionGranted = await _handleLocationPermission();
    if (!permissionGranted) return;

    Position position;
    try {
      // Configurações específicas para Android, iOS e Web
      LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high, // Precisão alta
        distanceFilter: 50, // Atualiza a cada 100 metros
      );

      // Obtém a localização atual com as configurações definidas
      position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );

      // Atualiza a posição do mapa após obter a localização
      setState(() {
        _locationMessage =
            "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
        _center = LatLng(position.latitude, position.longitude); // Atualiza o centro com a nova localização
        mapController.animateCamera(CameraUpdate.newLatLng(_center)); // Move o mapa para a nova localização
      });
    } catch (e) {
      setState(() {
        _locationMessage = "Erro ao obter localização: $e";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  GoogleMap( 
      onMapCreated: (GoogleMapController controller) {
          MapsServiceSingleton().setController(controller);
      },
      zoomControlsEnabled: false, 
      initialCameraPosition:CameraPosition(
        target: _center,
        zoom: 20.0,
      ),
      scrollGesturesEnabled: true,
      rotateGesturesEnabled: true,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      tiltGesturesEnabled: true,
      markers: _createMarkers(),
    );
  }
  Set<Marker> _createMarkers() {
    final List<Pico> markersData = [];
    return markersData.map((markerData) {
      return Marker(
        markerId: MarkerId(markerData.urlIdPico),
        position: LatLng(markerData.lat, markerData.long),
      );
    }).toSet();
  }
}

