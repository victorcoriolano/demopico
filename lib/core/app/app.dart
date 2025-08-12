
import 'package:demopico/core/app/providers/providers.dart';
import 'package:demopico/core/app/routes/app_pages.dart';
import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/app/theme/theme.dart';


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
        initialRoute: Paths.home,
        getPages: AppPages.routes,
      ),
    );
  }
}
