import 'dart:convert';

import 'package:demopico/core/common/geolocator/geolocator.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpClimateService {
  // TODO: APLICAR INJEÇÃO DE DEPENDÊNCIA 
  final Geopositioning _geolocator = Geopositioning();
  final String apiKey = dotenv.env['WEATHER_API_KEY']!;

  Future<Map<String, dynamic>> latLongRequest() async {
    Map<String, String> currentPosition;
    try {
      currentPosition = await _geolocator.latLongPosition;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    }
    final query = '${currentPosition['lat']},${currentPosition['long']}';
    final currentInfoUrl = Uri.https('api.weatherapi.com', 'v1/forecast.json',
        {'key': apiKey, 'q': query, 'lang': 'pt', 'days': '2'});
    try {
      Response response = await http.get(currentInfoUrl);
      debugPrint('${response.request}, ${response.headers}');
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body) as Map<String, dynamic>;
        debugPrint('GET Request Successful: ${response.statusCode}');
        debugPrint('Response: $result');
        return result;
      } else if (response.statusCode == 403) {
        debugPrint('GET Request Failed. Status code: ${response.statusCode}');
        throw Exception('The Access is forbidden, check your API key');
      } else {
        debugPrint('GET Request Failed. Status code: ${response.statusCode}');
        throw Exception('GET Request Failed.');
      }
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e);
    }
  }
}
