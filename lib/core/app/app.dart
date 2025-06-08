import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/features/home/provider/home_provider.dart';
import 'package:demopico/features/hub/domain/usecases/listar_comunicados_uc.dart';
import 'package:demopico/features/hub/domain/usecases/postar_comunicado_uc.dart';
import 'package:demopico/features/hub/presentation/pages/hub_page.dart';
import 'package:demopico/features/hub/presentation/providers/hub_provider.dart';
import 'package:demopico/features/mapa/presentation/controllers/add_pico_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/comment_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/historico_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_save_controller.dart';
import 'package:demopico/features/mapa/presentation/pages/map_page.dart';
import 'package:demopico/features/user/infra/services/user_auth_firebase_service.dart';
import 'package:demopico/features/user/presentation/controllers/auth_user_provider.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
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
        ChangeNotifierProvider(create: (_) => AuthUserProvider.getInstance),
        StreamProvider(
          create: (_) =>
              UserAuthFirebaseService.getInstance.getAuthStateChanges(),
          initialData: null,
        ),
        ChangeNotifierProvider(create: (_) => AddPicoProvider.getInstance),
        ChangeNotifierProvider(
            create: (_) => MapControllerProvider()),
        ChangeNotifierProvider(create: (_) => SpotSaveController.getInstance),
        ChangeNotifierProvider(
            create: (_) => SpotControllerProvider.getInstance),
        ChangeNotifierProvider(create: (_) => UserDatabaseProvider.getInstance),
        ChangeNotifierProvider(create: (_) => HistoricoController.getInstance),
        ChangeNotifierProvider(
          create: (_) => HubProvider(
            postarComunicado: PostarComunicado.getInstance,
            listarComunicado: ListarComunicado.getInstance,
          ),
        ),
        ChangeNotifierProvider(create: (_) => HomeProvider.getInstance),
        ChangeNotifierProvider(create: (_) => CommentController.getInstance),
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
