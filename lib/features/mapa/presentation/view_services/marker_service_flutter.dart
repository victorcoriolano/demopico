
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MarkerServiceFlutter {
  static MarkerServiceFlutter? _markerService;
  static MarkerServiceFlutter get getInstance {
    _markerService ??= MarkerServiceFlutter();
    return _markerService!;
  }

  List<Marker> markers = [];
  

 

  /* Map<String, BitmapDescriptor> get markerIcons => _markerIcons;
  
  Future<void> createIcons(List<Pico> picos) async {
    await Future.wait(
      picos.map(
        (pico){      
          return BitmapDescriptor.asset(
            const ImageConfiguration(size: Size(27, 32)), 
            "assets/images/Location.png",).then(
              (assets) => _markerIcons[pico.picoName] = assets);
        }
      
      )
    );
  }
   */

  Stream<Marker> preloadIcons(List<Pico> picos, void Function(Pico) onTap) async*{
    
      for (var pico in picos){
        debugPrint("transformando pico em marker: markers");
        var marker = Marker(
          child: Image.asset("assets/images/Location.png"),
          point: LatLng(pico.lat, pico.long)
        );
        markers.add(marker);
      yield marker;
    }
  }
}
