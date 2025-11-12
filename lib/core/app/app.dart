
import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/core/app/providers/providers.dart';
import 'package:demopico/core/app/routes/app_pages.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/home/presentation/widgets/central_page_background.dart';
import 'package:demopico/features/home/presentation/widgets/events_bottom_sheet.dart';
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
        home: HomePageTest(),
        debugShowCheckedModeBanner: false,
        title: 'SKATEPICO',
        theme: appTheme,
        checkerboardRasterCacheImages: true,
        getPages: AppPages.routes,
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
      body: Column(
        children: [
          SkatePicoLogo(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SearchBarSpots(
              onTapSuggestion: (pico) {
                context
                    .read<MapControllerProvider>()
                    .reajustarCameraPosition(LatLng(pico.location.latitude, pico.location.longitude));
                ModalHelper.openModalInfoPico(
                    context, pico);
                    }),
          ),
          
        SizedBox(height: 20),
        Stack(
          fit: StackFit.loose,
          children: [
            EventsBottomSheet(),          
          ],
        )

        //DraggableBackground(),
        ],
      ),
    );
  }
}

class DraggableBackground extends StatelessWidget {
  const DraggableBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[20],
        borderRadius: BorderRadius.vertical(top: Radius.circular(16), bottom: Radius.circular(0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: BorderSide.strokeAlignInside,
            blurStyle: BlurStyle.solid,
            blurRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      height: 110,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          "ACESSAR O MENU",
          style: TextStyle(
            fontSize: 18,
            height: 10,
            decorationThickness: 2,
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.wavy,
            decorationColor: Color(0xFFB0BEC5),
            shadows: [
              Shadow(
                color: Colors.black26,
                offset: Offset(1, 3),
                blurRadius: 2,
              ),
            ],
            fontFamily: 'CupertinoSystemDisplay',
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey[800],
          ),
        ),
      ),
    );
  }
}