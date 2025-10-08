import 'package:demopico/features/home/presentation/widgets/central_page_background.dart';
import 'package:demopico/features/home/presentation/widgets/events_bottom_sheet.dart';
import 'package:demopico/features/home/presentation/widgets/hub_upper_sheet.dart';
import 'package:demopico/features/home/presentation/widgets/top_level_home_row.dart';
import 'package:flutter/material.dart';

class CentralPage extends StatefulWidget {
  const CentralPage({super.key});

  @override
  State<CentralPage> createState() => _CentralPageState();
}

class _CentralPageState extends State<CentralPage> {
  final ScrollController scrollController = ScrollController();

  



  @override
  Widget build(BuildContext context) {
    
    //final user = context.read<AuthViewModelAccount>().authState;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                CentralPageBackground(),
                /* Consumer<OpenWeatherProvider>(
                  builder: (context, weatherProvider, child) {
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
                     */
                     TopLevelHomeRow(
                      /* userImage: switch (user) {
                        AuthAuthenticated() => user.user.avatar,
                        AuthUnauthenticated() => null,
                      },
                      initialWeatherInfo: weatherData, */
                                         ),
                  //},
                //)
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
