
import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/core/app/providers/providers.dart';
import 'package:demopico/core/app/routes/app_pages.dart';
import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/home/presentation/widgets/central_page_background.dart';
import 'package:demopico/features/home/presentation/widgets/skatepico_logo.dart';
import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart' show MapControllerProvider;
import 'package:demopico/features/mapa/presentation/view_services/modal_helper.dart' show ModalHelper;
import 'package:demopico/features/mapa/presentation/widgets/search_bar.dart';
import 'package:demopico/features/profile/presentation/bidings/auth_biding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:provider/provider.dart';

class MyAppWidget extends StatelessWidget {
  const MyAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: myProviders,
      child: GetMaterialApp(
        //home: HomePageTest(),
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

class HomePageTest extends StatefulWidget {
  const HomePageTest({super.key});

  @override
  State<HomePageTest> createState() => _HomePageTestState();
}

class _HomePageTestState extends State<HomePageTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CentralPageBackground(),
          Center(
            child: Column(
              children: [
                SkatePicoLogo(),
                SearchBarSpots(
                  onTapSuggestion: (pico) {
                    context
                        .read<MapControllerProvider>()
                        .reajustarCameraPosition(LatLng(pico.location.latitude, pico.location.longitude));
                    ModalHelper.openModalInfoPico(
                        context, pico);
              }),
              Expanded(child: SizedBox(height: 20)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}