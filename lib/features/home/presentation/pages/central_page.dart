import 'package:demopico/features/home/presentation/widgets/central_page_background.dart';
import 'package:demopico/features/home/presentation/widgets/events_bottom_sheet.dart';
import 'package:demopico/features/home/presentation/widgets/hub_upper_sheet.dart';
import 'package:demopico/features/home/presentation/widgets/top_level_home_row.dart';
import 'package:demopico/features/home/presentation/provider/weather_provider.dart';
import 'package:demopico/features/user/presentation/controllers/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CentralPage extends StatefulWidget {
  const CentralPage({super.key});

  @override
  State<CentralPage> createState() => _CentralPageState();
}

class _CentralPageState extends State<CentralPage> {
  final ScrollController scrollController = ScrollController();


  bool _isWeatherLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isWeatherLoaded) {
        if (context.read<OpenWeatherProvider>()
            .isUpdated()) {
          debugPrint('Weather data already updated, skipping load.');
          return;
        }
        _loadWeather();
        _isWeatherLoaded = true;
      }
    });
  }

  Future<void> _loadWeather() async {
    try{
      await context.read<OpenWeatherProvider>()
        .fetchWeatherData();
        debugPrint('Weather data fetch called sucessfuly in HomePage');
        _isWeatherLoaded = false;
    } catch (e) {
      debugPrint('Error fetching weather data: $e');
      _isWeatherLoaded = false;
    }
    
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Stack(children: [
                CentralPageBackground(),
                Consumer2<OpenWeatherProvider, ProfileViewModel>(
                  builder: (context, weatherProvider, userDatabaseProvider, child) {
                    //Carrega os dados do clima de acordo com o estado
                    if (weatherProvider.isLoading) {
                      return Positioned(
                          top: 110,
                          left: 5,
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary,
                          )));
                    } else if (weatherProvider.errorMessage != null) {
                      return Positioned(
                        top: 110,
                        left: 5,
                        child: Center(
                          child: Text(
                            weatherProvider.errorMessage!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    }
                    //Obtém o modelo de clima atual, mapeia os iniciais e passa pro widget
                    final currentWeatherModel = weatherProvider.value;
                    final weatherData = {
                      'temperature': currentWeatherModel?.tempC ?? 0,
                      'isDay': currentWeatherModel?.isDay ?? true,
                    };
                    return TopLevelHomeRow(
                      userImage: userDatabaseProvider.user?.pictureUrl,
                      initialWeatherInfo: weatherData,
                    );
                  },
                ),
              ]),
            ],
          ),
          HubUpperSheet(),
          EventsBottomSheet(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    debugPrint('CentralPage disposed');
    super.dispose();
  }
}
