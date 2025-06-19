import 'package:demopico/core/common/ui_context_extension.dart';
import 'package:demopico/features/home/provider/forecast_provider.dart';
import 'package:demopico/features/home/provider/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeatherDialog extends StatefulWidget {
  const WeatherDialog({super.key});

  @override
  State<WeatherDialog> createState() => _WeatherDialogState();
}

// TODO: REFACTOR THIS UI !!!!!!!!!!!

class _WeatherDialogState extends State<WeatherDialog> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final providerValue =
          Provider.of<OpenWeatherProvider>(context, listen: false);
      final forecastValue =
          Provider.of<ForecastProvider>(context, listen: false);
      createModels(context, providerValue, forecastValue);
      debugPrint('WeatherDialog: Models created ${DateTime.now()}');
    });
  }

  void createModels(BuildContext context, OpenWeatherProvider providerValue,
      ForecastProvider forecastValue) {
    if (providerValue.value == null) {
      if (Navigator.canPop(context)) Navigator.pop(context);
    }
    if (forecastValue.value == null) {
      forecastValue.getForecast();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<OpenWeatherProvider, ForecastProvider>(
        builder: (context, providerValue, forecastValue, child) {
      if (providerValue.value == null ||
          forecastValue.value == null ||
          providerValue.isLoading ||
          forecastValue.isLoading) {
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
            constraints: BoxConstraints.expand(),
          ),
        );
      } else {
        final weatherModel = providerValue.value;
        final forecastModel = forecastValue.value;
        return Center(
          child: AlertDialog(
            surfaceTintColor: Color.fromARGB(162, 175, 97, 97),
            backgroundColor: Color(0xFFD9D9D9),
            elevation: 8,
            title: Text("Instruções Climáticas"),
            titleTextStyle: TextStyle(
                fontSize: 12, color: Colors.black, fontFamily: 'Misfit'),
            content: SizedBox(
              height: context.screenHeight * 0.6,
              width: context.screenWidth * 0.9,
              child: Stack(
                children: [
                  Positioned(
                      top: 50, left: 60, child: Icon(Icons.wb_sunny_sharp)),
                  Positioned(
                      top: 50,
                      right: 60,
                      child: Icon(Icons.thunderstorm_sharp)),
                  Positioned(
                      top: 60,
                      left: 60,
                      child: Text('${weatherModel?.tempC ?? 0}°C')),
                  Positioned(
                    top: 60,
                    right: 60,
                    child: Text('${forecastModel?.avgTempC ?? 0}°C'),
                  ),
                  Positioned(
                      top: 70,
                      left: 60,
                      child: Row(
                        children: [
                          Icon(Icons.air_rounded),
                          Text('${weatherModel?.windKpH ?? 0} km/H'),
                        ],
                      )),
                  Positioned(
                      top: 70,
                      right: 60,
                      child: Row(
                        children: [
                          Icon(Icons.air_rounded),
                          Text('${forecastModel?.windKpH ?? 0} km/H'),
                        ],
                      )),
                  Positioned(top: 40, left: 55, child: Text("Hoje")),
                  Positioned(top: 40, right: 55, child: Text("Amanhã")),
                  Positioned(
                      top: 90,
                      right: context.screenWidth * 0.5,
                      left: context.screenWidth * 0.5,
                      child: Text(
                          "Descrição conselheira Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum ")),
                ],
              ),
            ),
            actions: null,
          ),
        );
      }
    });
  }
}
