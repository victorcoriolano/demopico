import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapControllerProvider extends ChangeNotifier {
  GoogleMapController? _mapController;
  LatLng center =
      const LatLng(-23.550104, -46.633953); // Inicializa o centro do mapa
  String locationMessage = '';
  MapType myMapType = MapType.normal;
  double zoomInicial = 12;
  final completer = Completer<GoogleMapController>();
  bool alreaySetController = false;

  GoogleMapController? get mapController => _mapController;

  //setando o controller para manipular em qualquer lugar do código
  void setGoogleMapController(GoogleMapController controller) {
    if (_mapController != null) {
      return;
    }
    _mapController = controller;
    completer.complete(controller);
    notifyListeners();
  }

  void reajustarCameraPosition(LatLng position)  {
    //movendo a camera position
    debugPrint("Reajustando a camera position");
    completer.future.then((controller) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: position,
            zoom: 15,
          ),
        ),
      );
    });
    
    
    notifyListeners();
  }

  void setZoom(double zoomLevel) {
    //alterar o zoom
    zoomInicial = zoomLevel;
    _mapController!.animateCamera(CameraUpdate.zoomTo(zoomLevel));
    notifyListeners();
  }

  void setMapType(MapType mapType) {
    //alterar o tipo do mapa
    myMapType = mapType;
    notifyListeners();
  }

  // Função para verificar permissões
  Future<bool> _handleLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      // Solicita permissão
      status = await Permission.location.request();
      if (!status.isGranted) {
        // Se o usuário negar a permissão, exibe uma mensagem
        locationMessage = "Permissão de localização negada.";
        return false;
      }
    }
    notifyListeners();
    return true;
  }

  // Função para obter a localização
  Future<void> getLocation() async {
    bool permissionGranted = await _handleLocationPermission();
    if (permissionGranted) {
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
        locationMessage =
            "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
        center = LatLng(position.latitude,
            position.longitude); // Atualiza o centro com a nova localização
        reajustarCameraPosition(center); // Move o mapa para a nova localização
        notifyListeners();
      } catch (e) {
        locationMessage = "Erro ao obter localização: $e";
        notifyListeners();
      }
    }
  }
}
