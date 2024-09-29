import 'package:demopico/core/errors/failure_server.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsServiceSingleton {

  static final MapsServiceSingleton _instance = MapsServiceSingleton._internal();
  GoogleMapController? _controller;

  factory MapsServiceSingleton(){
    return _instance;
  }
  MapsServiceSingleton._internal();

  void setController(GoogleMapController controller){
    _controller = controller;
  } 

  GoogleMapController get controller {
    if (_controller == null) {
      throw NotSetMapController();
    }
    return _controller!;
  }
  bool get isControllerSet => _controller != null;

}