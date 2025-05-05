import 'package:demopico/app/home_page.dart';
import 'package:demopico/features/hub/domain/usecases/listar_comunicados_uc.dart';
import 'package:demopico/features/hub/domain/usecases/postar_comunicado_uc.dart';
import 'package:demopico/features/hub/infra/repository/hub_repository.dart';

import 'package:demopico/features/hub/presentation/pages/hub_page.dart';
import 'package:demopico/features/hub/presentation/providers/hub_provider.dart';
import 'package:demopico/features/mapa/data/services/service_firebase_comment.dart';

import 'package:demopico/features/mapa/data/services/service_firebase_storage_images.dart';
import 'package:demopico/features/mapa/data/services/service_local_historico.dart';
import 'package:demopico/features/mapa/data/services/service_image_picker.dart';
import 'package:demopico/features/mapa/domain/usecases/comment_spot_uc.dart';
import 'package:demopico/features/mapa/domain/usecases/pick_image_uc.dart';
import 'package:demopico/features/mapa/domain/usecases/save_history_spot_uc.dart';
import 'package:demopico/features/mapa/domain/usecases/save_image_uc.dart';
import 'package:demopico/features/mapa/presentation/controllers/add_pico_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/comment_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/historico_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_controller.dart';
import 'package:demopico/features/mapa/presentation/pages/map_page.dart';
import 'package:demopico/features/user/data/services/auth_service.dart';
import 'package:demopico/features/user/data/services/user_service.dart';
import 'package:demopico/features/user/presentation/controllers/database_notifier_provider.dart';
import 'package:demopico/core/common/inject_dependencies.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../features/external/datasources/firestore.dart';
import '../features/hub/infra/services/hub_service.dart';

class MyAppWidget extends StatelessWidget {
  MyAppWidget({super.key});

  final Firestore firestoreInstance = Firestore();
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
        ChangeNotifierProvider(
            create: (_) => AddPicoProvider(
                PickImageUC(ServiceImagePicker()),
                SaveImageUC(ServiceFirebaseStorageImages(
                    FirebaseStorage.instance)))),
        ChangeNotifierProvider(create: (_) => MapControllerProvider()),
        ChangeNotifierProvider(
            create: (_) => serviceLocator<SpotControllerProvider>()),
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
        ChangeNotifierProvider(
            create: (_) =>
                HistoricoController(SaveHistoryUc(ServiceLocalHistory()))),
        ChangeNotifierProvider(
          create: (_) => HubProvider(
            postarComunicado: PostarComunicado(
              hubService: HubService(
                userService: UserService(firestore: Firestore()),
                iHubRepository: HubRepository(firestore: Firestore()),
              ),
            ),
            listarComunicado: ListarComunicado(
                hubService: HubService(
              userService: UserService(firestore: Firestore()),
              iHubRepository: HubRepository(firestore: Firestore()),
            )),
          ),
        ),
        ChangeNotifierProvider(
            create: (_) => HubProvider(
                postarComunicado: PostarComunicado(
                    hubService: HubService(
                        userService: UserService(firestore: Firestore()),
                        iHubRepository:
                            HubRepository(firestore: firestoreInstance))),
                listarComunicado: ListarComunicado(
                    hubService: HubService(
                        userService: UserService(firestore: Firestore()),
                        iHubRepository:
                            HubRepository(firestore: firestoreInstance))))),
        ChangeNotifierProvider(
            create: (_) =>
                CommentController(CommentSpotUC(ServiceFirebaseComment()))),
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
