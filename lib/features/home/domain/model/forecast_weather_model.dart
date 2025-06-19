class ForecastWeatherModel extends Object {
  final String date;
  final double? avgTempC;
  final double? avgTempF;
  final String text;
  final double? windKpH;
  final int? humidity;
  final bool willRain;

  ForecastWeatherModel(Map<String, dynamic> json)
      : date = json['forecast']['forecastday'][1]['date'] as String,
        avgTempC =
            json['forecast']['forecastday'][1]['avgtemp_c'] ?? 0.toDouble(),
        avgTempF =
            json['forecast']['forecastday'][1]['avgtemp_f'] ?? 0.toDouble(),
        text = json['forecast']['forecastday'][1]['day']['condition']['text']
            as String,
        windKpH = json['forecast']['forecastday'][1]['day']['maxwind_kph'] ??
            0.toDouble(),
        humidity = json['forecast']['forecastday'][1]['day']['avghumidity'] ??
            0 as num,
        willRain = (json['forecast']['forecastday'][1]['will_it_rain'] is num &&
                json['forecast']['forecastday'][1]['will_it_rain'] == 1)
            ? true
            : false {
    if (json.isEmpty || json['forecast'] == null) {
      throw Exception('The JSON data that the weather model received is empty');
    }
  }
}
