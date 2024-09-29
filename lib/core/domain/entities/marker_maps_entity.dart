import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerData {
  final String id;
  final LatLng position;

  MarkerData({required this.id, required this.position});
}



Set<Marker> createMarkers(List<Pico> markersData) {
  return markersData.map((markerData) {
    return Marker(
      markerId: MarkerId(markerData.urlIdPico),
      position: ,
    );
  }).toSet();
}