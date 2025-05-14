import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/features/home/provider/home_provider.dart';
import 'package:demopico/features/hub/domain/usecases/listar_comunicados_uc.dart';
import 'package:demopico/features/hub/domain/usecases/postar_comunicado_uc.dart';
import 'package:demopico/features/hub/presentation/pages/hub_page.dart';
import 'package:demopico/features/hub/presentation/providers/hub_provider.dart';
import 'package:demopico/features/mapa/domain/usecases/comment_spot_uc.dart'; // novo
import 'package:demopico/features/mapa/domain/usecases/pick_image_uc.dart'; // novo
import 'package:demopico/features/mapa/domain/usecases/save_history_spot_uc.dart'; // novo
import 'package:demopico/features/mapa/domain/usecases/save_image_uc.dart'; // novo
import 'package:demopico/features/mapa/presentation/controllers/add_pico_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/comment_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/historico_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_controller.dart';
import 'package:demopico/features/mapa/presentation/pages/map_page.dart';
import 'package:demopico/features/mapa/data/services/image_picker_service.dart'; // novo
import 'package:demopico/features/mapa/data/services/firebase_files_service.dart'; // novo
import 'package:demopico/features/mapa/data/services/firebase_comment_service.dart'; // novo
import 'package:demopico/features/mapa/data/services/local_storage_service.dart'; // novo
import 'package:demopico/features/profile/presentation/provider/profile_provider.dart'; // novo
import 'package:demopico/features/user/infra/services/user_auth_firebase_service.dart';
import 'package:demopico/features/user/presentation/controllers/auth_user_provider.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:firebase_storage/firebase_storage.dart'; // novo
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // novo
import 'package:demopico/core/common/inject_dependencies.dart'; // novo

class MyAppWidget extends StatelessWidget {
  const MyAppWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // providers de auth e user data
        ChangeNotifierProvider(create: (_) => AuthUserProvider.getInstance),
        StreamProvider(
          create: (_) =>
              UserAuthFirebaseService.getInstance.getAuthStateChanges(),
          initialData: null,
        ),
        ChangeNotifierProvider(create: (_) => UserDatabaseProvider.getInstance),
        ChangeNotifierProvider(create: (_) => ProfileProvider.getInstance), // novo

        // provider mapa
        ChangeNotifierProvider(create: (_) => AddPicoProvider(
          PickImageUC(ImagePickerService()),
          SaveImageUC(FirebaseFilesService(FirebaseStorage.instance)),
        )), // novo
        ChangeNotifierProvider(create: (_) => MapControllerProvider()),
        ChangeNotifierProvider(create: (_) => SpotControllerProvider()), // ajustado para construtor direto
        ChangeNotifierProvider(create: (_) => CommentController(
          CommentSpotUC(FirebaseCommentService(FirebaseFirestore.instance)),
        )), // novo
        ChangeNotifierProvider(create: (_) => HistoricoController(
          SaveHistoryUc(LocalStorageService()),
        )), // novo

        // provider hub
        ChangeNotifierProvider(
          create: (_) => HubProvider(
            postarComunicado: PostarComunicado.getInstance,
            listarComunicado: ListarComunicado.getInstance,
          ),
        ),

        // provider home
        ChangeNotifierProvider(create: (_) => HomeProvider.getInstance),
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
