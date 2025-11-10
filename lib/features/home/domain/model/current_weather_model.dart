class CurrentWeatherModel extends Object {
  final String lastUpdated;
  final double tempC;
  final double tempF;
  final String text;
  final bool isDay;
  final double windKpH;
  final int humidity;
  final int cloud;
  final DateTime? dateOfBirth;

  CurrentWeatherModel(Map<String, dynamic> json)
      : lastUpdated = json['current']['last_updated'] as String,
      dateOfBirth = DateTime.tryParse(json['current']['last_updated']) ?? DateTime.now(),
        tempC = json['current']['temp_c'] as double,
        tempF = json['current']['temp_f'] as double,
        text = json['current']['condition']['text'] as String,
        isDay = json['current']['is_day'] == 1,
        windKpH = json['current']['wind_kph'] as double,
        humidity = json['current']['humidity'] as int,
        cloud = json['current']['cloud'] as int {
    if (json.isEmpty || json['current'] == null) {
      throw Exception('The JSON data that the weather model received is empty');
    }
  }

  bool areEquals(
      CurrentWeatherModel currentModel, CurrentWeatherModel updatedModel) {
    if (lastUpdated == updatedModel.lastUpdated &&
            isDay == updatedModel.isDay &&
            tempC == updatedModel.tempC &&
            tempF == updatedModel.tempF &&
            windKpH == updatedModel.windKpH &&
            humidity == updatedModel.humidity &&
            cloud == updatedModel.cloud &&
            text == updatedModel.text ||
        currentModel.hashCode == updatedModel.hashCode) {
      return true;
    } else {
      return false;
    }
  }
}
