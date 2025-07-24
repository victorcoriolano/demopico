import 'package:demopico/core/app/auth_wrapper.dart';
import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/core/app/providers/providers.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/hub/presentation/pages/hub_page.dart';
import 'package:demopico/features/mapa/presentation/pages/map_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyAppWidget extends StatelessWidget {
  const MyAppWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: myProviders,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SKATEPICO',
        theme: appTheme,
        checkerboardRasterCacheImages: true,
        
        routes: {
          '/': (context) => const HomePage(),
          '/HubPage': (context) => const HubPage(),
          '/MapPage': (context) => const MapPage(),
          '/AuthWrapper': (context) => const AuthWrapper(),
        },
      ),
    );
  }
}
