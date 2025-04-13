import 'package:demopico/app/home_page.dart';
import 'package:demopico/features/hub/presentation/providers/database_notifier_provider.dart';
import 'package:demopico/features/hub/presentation/pages/hub_page.dart';
import 'package:demopico/features/mapa/data/services/comment_data_service.dart';
import 'package:demopico/features/mapa/data/services/historico_storage.dart';
import 'package:demopico/features/mapa/domain/use%20cases/comment_spot.dart';
import 'package:demopico/features/mapa/domain/use%20cases/historico_use_case.dart';
import 'package:demopico/features/mapa/domain/use%20cases/save_spot.dart';
import 'package:demopico/features/mapa/presentation/controllers/add_pico_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/comment_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/historico_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_save_controller.dart';
import 'package:demopico/features/mapa/presentation/pages/map_page.dart';
import 'package:demopico/features/user/data/services/auth_service.dart';
import 'package:demopico/features/user/presentation/controllers/database_notifier_provider.dart';
import 'package:demopico/core/common/inject_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyAppWidget extends StatelessWidget {
  const MyAppWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => serviceLocator<AuthService>(),
        ),
        StreamProvider(
          create: (_) => serviceLocator<AuthService>().getAuthStateChanges(),
          initialData: null,
        ),
        ChangeNotifierProvider(create: (_) => AddPicoControllerProvider()),
        ChangeNotifierProvider(create: (_) => MapControllerProvider()),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<SpotControllerProvider>()),
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
        ChangeNotifierProvider(
            create: (_) => SpotSaveController(serviceLocator<SaveSpot>())),
        ChangeNotifierProvider(
            create: (_) =>
                HistoricoController(HistoricoUseCase(HistoricoStorage()))),
        ChangeNotifierProvider(create: (_) => HubProvider()),
        ChangeNotifierProvider(
            create: (_) =>
                CommentController(CommentSpotUC(CommentRepository()))),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SKATEPICO',
        theme: ThemeData(
          // This is the theme of your application.
          // TRY THIS: changing the seedColor in the colorScheme below
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 139, 0, 0)),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => const HomePage(),
          '/hub': (context) => const HubPage(),
          '/map': (context) => const MapPage(),
        },
      ),
    );
  }
}
