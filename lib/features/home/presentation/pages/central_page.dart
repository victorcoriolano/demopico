import 'package:demopico/features/home/presentation/widgets/central_page_background.dart';
import 'package:demopico/features/home/presentation/widgets/events_bottom_sheet.dart';
import 'package:demopico/features/home/presentation/widgets/hub_upper_sheet.dart';
import 'package:demopico/features/home/presentation/widgets/top_level_home_row.dart';
import 'package:demopico/features/home/provider/weather_provider.dart';
import 'package:demopico/features/user/presentation/controllers/auth_user_provider.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CentralPage extends StatefulWidget {
  const CentralPage({super.key});

  @override
  State<CentralPage> createState() => _CentralPageState();
}

class _CentralPageState extends State<CentralPage> {
  final ScrollController scrollController = ScrollController();
  late UserDatabaseProvider _userDatabaseProvider;
  late AuthUserProvider _authUserProvider;
  String? _userId;
  String? _userImage;

  bool _isWeatherLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUser();
      if (!_isWeatherLoaded) {
        if (Provider.of<OpenWeatherProvider>(context, listen: false)
            .isUpdated()) {
          debugPrint('Weather data already updated, skipping load.');
          return;
        }
        _loadWeather();
        _isWeatherLoaded = true;
      }
    });
  }

  void _loadWeather() async {
    await Provider.of<OpenWeatherProvider>(context, listen: false)
        .fetchWeatherData();
    debugPrint('Weather data fetch called sucessfuly in HomePage');
    debugPrint(
        'Value ${Provider.of<OpenWeatherProvider>(context, listen: false).value}');
  }

  Future<void> _loadUser() async {
    _userDatabaseProvider =
        Provider.of<UserDatabaseProvider>(context, listen: false);
    _authUserProvider = Provider.of<AuthUserProvider>(context, listen: false);
    _userId = _authUserProvider.pegarId();
    if (_userId != null) {
      await _userDatabaseProvider.retrieveUserProfileData(_userId!);
    }
    if (_userId != null) {
      final user = _userDatabaseProvider.user;

      if (user != null) _userImage = user.pictureUrl;
    }
    return;
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
                Consumer<OpenWeatherProvider>(
                  builder: (context, weatherProvider, child) {
                    //Carrega os dados do clima de acordo com o estado
                    if (weatherProvider.isLoading ||
                        weatherProvider.value == null) {
                      return Positioned(
                          top: 110,
                          left: 5,
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary,
                          )));
                    } else if (weatherProvider.errorMessage != null) {
                      return Positioned(
                        top: 70,
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
                      userImage: _userImage,
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
    _userDatabaseProvider.dispose();
    _authUserProvider.dispose();
    debugPrint('CentralPage disposed');
    super.dispose();
  }
}
