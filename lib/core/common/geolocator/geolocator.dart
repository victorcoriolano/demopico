import 'dart:async';

import 'package:geolocator/geolocator.dart';

class Geopositioning {
  Geopositioning._privateConstructor();
  static final Geopositioning _instance = Geopositioning._privateConstructor();
  factory Geopositioning() => _instance;

  Future<Map<String, String>> get latLongPosition => _getLatLongPosition();
  Future<Position?> get getLastKnownPosition => _getLastKnownPosition();

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        locationSettings: locationSettings);
  }

  Future<Position?> _getLastKnownPosition() async {
    final response = await Geolocator.getLastKnownPosition();
    return response;
  }

  Future<Map<String, String>> _getLatLongPosition() async {
    Position position = await _determinePosition();
    final latLong = {
      'lat': '${position.latitude}',
      'long': '${position.longitude}'
    };
    return latLong;
  }
}
