import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapControllerProvider extends ChangeNotifier{
  GoogleMapController? _mapController;
  LatLng center = const LatLng(-23.548546, -46.9400143);// Inicializa o centro do mapa
  String locationMessage = '';

  GoogleMapController? get mapController => _mapController;

  void setGoogleMapController(GoogleMapController controller){ //setando o controller
    _mapController = controller;
    notifyListeners();
  }

  void reajustarCameraPosition(LatLng position){ //movendo a camera position
    if(_mapController != null){
      _mapController!.animateCamera(CameraUpdate.newLatLng(position));
    }
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
        locationMessage = "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
        center = LatLng(position.latitude, position.longitude); // Atualiza o centro com a nova localização
        reajustarCameraPosition(center); // Move o mapa para a nova localização
        notifyListeners();
        print(locationMessage);
      } 
      catch (e) {
          locationMessage = "Erro ao obter localização: $e";
          notifyListeners();
          print(locationMessage);
      }
    }
  }

}