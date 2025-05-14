import 'dart:ui';

import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/presentation/widgets/icon_marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class MarkerService {
  final Map<String, BitmapDescriptor> _markerIcons = {};

  Map<String, BitmapDescriptor> get markerIcons => _markerIcons;

  Future<void> preloadIcons(List<Pico> picos) async {
    for (final pico in picos) {
      final icon = await const IconMarker(
        text: '', // Você pode colocar nome ou outro dado aqui
      ).toBitmapDescriptor(
        logicalSize: const Size(150, 150),
        imageSize: const Size(120, 150),
      );
      _markerIcons[pico.picoName] = icon;
    }
  }

  Set<Marker> createMarkers(List<Pico> picos, void Function(Pico) onTapPico) {
    return picos.map((pico) {
      return Marker(
        markerId: MarkerId(pico.picoName),
        position: LatLng(pico.lat, pico.long),
        icon: _markerIcons[pico.picoName] ?? BitmapDescriptor.defaultMarker,
        onTap: () => onTapPico(pico),
      );
    }).toSet();
  }
}