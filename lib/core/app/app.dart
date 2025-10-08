
import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/core/app/providers/providers.dart';
import 'package:demopico/core/app/routes/app_pages.dart';
import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/profile/presentation/bidings/auth_biding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyAppWidget extends StatelessWidget {
  const MyAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: myProviders,
      child: GetMaterialApp(
        initialRoute: Paths.home,
        debugShowCheckedModeBanner: false,
        title: 'SKATEPICO',
        theme: appTheme,
        checkerboardRasterCacheImages: true,
        getPages: AppPages.routes,
        home: const HomePage(),
        initialBinding: AuthBinding(),
      ),
    );
  }
}
