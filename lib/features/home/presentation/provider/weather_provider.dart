import 'package:demopico/features/home/domain/model/current_weather_model.dart';
import 'package:demopico/features/home/infra/http_climate_service.dart';
import 'package:flutter/widgets.dart';

class OpenWeatherProvider extends ValueNotifier<CurrentWeatherModel?> {
  OpenWeatherProvider() : super(null);
  bool isLoading = false;
  String? errorMessage;

  bool imOld() {
    if (value == null) return true;
    final now = DateTime.now();
    final dob = value!.dateOfBirth; 
    Duration difference = dob!.difference(now);
    return difference.inMinutes.abs() > 20;
  }

  bool isUpdated() {
    return value != null &&
            !isLoading &&
            errorMessage == null &&
            !value!.tempC.isNaN ||
        !imOld();
  }

  final HttpClimateService _httpClimateService = HttpClimateService();

  Future<void> fetchWeatherData() async {
    if (isLoading) return; //Retorna se já estiver carregando uma requisição
    final Map<String, dynamic> weatherData;
    //Notifica que está carregando
    isLoading = true;
    notifyListeners();
    debugPrint('PROVIDERMETHOD: Fetching weather data...');
    try {
      //Requisição GET para a API de clima (weatherapi)
      weatherData = await _httpClimateService.latLongRequest();
      debugPrint(
          'PROVIDERMETHOD: Weather data fetched successfully: $weatherData');
      //Valor atualizado
      value = CurrentWeatherModel(weatherData);
      debugPrint('PROVIDERMETHOD: Value updated: ${value!.text}');
      debugPrint(value?.tempC.toString());
    } on Exception catch (e) {
      debugPrint('PROVIDERMETHOD: Error fetching weather data: $e');
      errorMessage = "ERRO!";
      value = null;
    } finally {
      isLoading = false;
      //Notifica que terminou de carregar
      notifyListeners();
    }
  }
}
