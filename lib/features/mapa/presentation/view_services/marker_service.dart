
import 'dart:async';

import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerService {
  static MarkerService? _markerService;
  static MarkerService get getInstance {
    _markerService ??= MarkerService();
    return _markerService!;
  }

  final Map<String, BitmapDescriptor> _markerIcons = {};
  Set<Marker> markers = {};

 

  Map<String, BitmapDescriptor> get markerIcons => _markerIcons;
  
  Future<void> createIcons(List<Pico> picos) async {
    await Future.wait(
      picos.map(
        (pico){      
          return BitmapDescriptor.asset(
            const ImageConfiguration(size: Size(27, 32)), 
            "images/Location.png",).then(
              (assets) => _markerIcons[pico.picoName] = assets);
        }
      
      )
    );
  }
  

  Stream<Marker> preloadIcons(List<Pico> picos, void Function(Pico) onTap) async*{
    
      await createIcons(picos);
      for (var pico in picos){
        yield Marker(
          markerId: MarkerId(pico.id),
          position: LatLng(pico.lat, pico.long),
          icon: _markerIcons[pico.picoName]!,
          onTap: () => onTap(pico),
        );
      
    }
  }
}
