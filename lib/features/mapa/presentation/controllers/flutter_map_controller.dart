import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class FlutterMapControllerProvider extends ChangeNotifier {
  MapControllerImpl? _mapController;
  LatLng center =
      const LatLng(-23.550104, -46.633953); // Inicializa o centro do mapa
  String locationMessage = '';
  // MapType myMapType = MapType.normal;
  double zoomInicial = 12;
  final completer = Completer<MapController>();
  bool alreaySetController = false;

  MapController? get mapController => _mapController;

  //setando o controller para manipular em qualquer lugar do código
  void setGoogleMapController(MapControllerImpl controller) {
    _mapController = controller;
    completer.complete(controller);
    notifyListeners();
  }

  void reajustarCameraPosition(LatLng position)  {
    //movendo a camera position
    debugPrint("Reajustando a camera position");
    _mapController?. moveAndRotateAnimatedRaw(position , 15, 0,source: MapEventSource.flingAnimationController,hasGesture: true, curve: Curves.linear,duration: Duration(milliseconds: 200), offset: Offset.zero);

  }

  void setZoom(double zoomLevel) {
    //alterar o zoom
    zoomInicial = zoomLevel;
    _mapController!.camera.clampZoom(zoomLevel);
    notifyListeners();
  }
}
