import 'package:demopico/features/home/domain/model/forecast_weather_model.dart';
import 'package:demopico/features/home/infra/http_climate_service.dart';
import 'package:flutter/widgets.dart';

class ForecastProvider extends ValueNotifier<ForecastWeatherModel?> {
  ForecastProvider(super.value);

  final HttpClimateService _climateProvider = HttpClimateService();
  HttpClimateService get climateProvider => _climateProvider;
  bool isLoading = false;

  bool imOld() {
    if (value == null) return true;
    return DateTime.now().difference(DateTime.parse((value as ForecastWeatherModel).date)).inMinutes.abs() > 20;
  }

  bool isUpdated() {
    return value != null &&
        !isLoading &&
        value is ForecastWeatherModel &&
        !imOld();
  }

  getForecast() async {
    try {
      isLoading = true;
      notifyListeners();
      final Map<String, dynamic> forecastData =
          await _climateProvider.latLongRequest();
      value = ForecastWeatherModel(forecastData);
    } catch (e) {
      debugPrint('Error fetching forecast data: $e');
      value = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
