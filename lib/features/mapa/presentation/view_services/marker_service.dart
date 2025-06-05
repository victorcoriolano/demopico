import 'dart:ui';

import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/presentation/view_services/modal_helper.dart';
import 'package:demopico/features/mapa/presentation/widgets/icon_marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class MarkerService {
  static MarkerService? _markerService;
  static MarkerService get getInstance {
    _markerService ??= MarkerService();
    return _markerService!;
  }

  final Map<String, BitmapDescriptor> _markerIcons = {};
  Set<Marker> markers = {};

  Map<String, BitmapDescriptor> get markerIcons => _markerIcons;

  Future<void> preloadIcons(List<Pico> picos) async {
    for (final pico in picos) {
      // carrega os icons 
      final icon = await IconMarker(
        text: pico.picoName, 
      ).toBitmapDescriptor(
        logicalSize: const Size(150, 150),
        imageSize: const Size(120, 150),
      );
      _markerIcons[pico.picoName] = icon;

      // carrega os markers 
      final marker = Marker(
        markerId: MarkerId(pico.picoName),
        position: LatLng(pico.lat, pico.long),
        icon: _markerIcons[pico.picoName] ?? BitmapDescriptor.defaultMarker,
        onTap: () => ModalHelper.openModalInfoPico,
      );
      markers.add(marker);
    }
  }
}
