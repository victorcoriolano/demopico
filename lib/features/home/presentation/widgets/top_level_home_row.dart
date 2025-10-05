import 'package:cached_network_image/cached_network_image.dart';
import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';

import 'package:demopico/features/home/infra/dialog_page_route.dart';
import 'package:demopico/features/home/presentation/provider/weather_provider.dart';
import 'package:demopico/features/home/presentation/widgets/weather_dialog.dart';
import 'package:demopico/features/user/domain/enums/auth_state.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class TopLevelHomeRow extends StatefulWidget {
  const TopLevelHomeRow({
    super.key,
  });


  @override
  State<TopLevelHomeRow> createState() => _TopLevelHomeRowState();
}

// TODO: IMPLEMENT HERO TO THE CLIMATE ICON

class _TopLevelHomeRowState extends State<TopLevelHomeRow> {

  bool _isWeatherLoaded = false;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('didChangeDependencies called in TopLevelHomeRow');
   
      if (!_isWeatherLoaded) {
        if (context.read<OpenWeatherProvider>()
            .isUpdated()) {
          debugPrint('Weather data already updated, skipping load.');
          return;
        }
        _loadWeather();
        _isWeatherLoaded = true;
      }
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
   
    return Positioned(
      top: 110,
      right: 10,
      left: 10,
      //Caixa que contém a row
      child: SizedBox(
        width: MediaQuery.maybeSizeOf(context)!.width,
        height: 120,
        //Row
        child: Row(
          children: [
            //BOTÃO DE CLIMA
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              verticalDirection: VerticalDirection.down,
              children: [
                Consumer<OpenWeatherProvider>(
                  builder: (context, provider, child) {
                    return provider.isLoading 
                      ? Positioned(
                          top: 110,
                          left: 5,
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary,
                          )))
                    : provider.errorMessage != null
                      ? Positioned(
                        top: 110,
                        left: 5,
                        child: Center(
                          child: Text(
                            provider.errorMessage!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      )
                    
                      : ElevatedButton(
                      onPressed: () => Navigator.push(context,
                          WeatherDialogRoute(builder: (context) {
                        return WeatherDialog();
                      })),
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.fromLTRB(15, 15, 15, 15)),
                        backgroundColor: WidgetStateProperty.all<Color>(
                            Color.fromARGB(255, 255, 255, 255)),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        )),
                        elevation: WidgetStateProperty.all<double>(3),
                        shadowColor: WidgetStateProperty.all<Color>(
                            Color.fromARGB(255, 0, 0, 0)),
                      ),
                      child: Row(
                        children: [
                          Icon(provider.value?.isDay == true ? Icons.wb_sunny : Icons.nightlight_round,
                              size: 38, color: Colors.black87),
                          SizedBox(width: 10),
                          Text('${provider.value?.tempC}°C',
                              style: TextStyle(fontSize: 20, color: Colors.black87))
                          ],
                        ),
                      ) ;
                  }
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () => Get.toNamed(Paths.profile),
              child: Consumer<AuthViewModelAccount>(
                builder: (context, provider, child) {
                    final user = provider.authState;
                    switch (user){
                      case AuthAuthenticated():
                        final user = provider.user as UserEntity;
                        final avatar = user.avatar;
                        return avatar == null 
                          ? Icon(
                              Icons.supervised_user_circle,
                              size: 64,
                              color: Colors.black,
                            ) 
                          : CircleAvatar(
                              radius: 32,
                              backgroundImage:
                                CachedNetworkImageProvider(avatar),
                              backgroundColor: Colors.transparent
                            );
                      case AuthUnauthenticated():
                        return Icon(
                            Icons.supervised_user_circle,
                            size: 64,
                            color: Colors.black,
                          );
                    }
                  
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
