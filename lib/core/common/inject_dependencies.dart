import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/mapa/data/repository/firebase_repository_map.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';
import 'package:demopico/features/mapa/domain/usecases/avaliar_spot_uc.dart';
import 'package:demopico/features/mapa/domain/usecases/create_spot_uc.dart';
import 'package:demopico/features/mapa/domain/usecases/save_spot_uc.dart';
import 'package:demopico/features/mapa/domain/usecases/list_spot_uc.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_save_controller.dart';
import 'package:demopico/features/user/data/services/auth_service.dart';
import 'package:demopico/features/user/presentation/controllers/database_notifier_provider.dart';
import 'package:demopico/features/user/data/services/database_service.dart';
import 'package:demopico/features/user/presentation/controllers/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> init() async {
  //espera todas as dependencias serem instanciadas?

  // Features - Auth

  //FirebaseAuth
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);

  //FirebaseFirestore
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);

  // Services
  serviceLocator.registerFactory<DatabaseService>(() => DatabaseService());

  serviceLocator.registerLazySingleton<AuthService>(() => AuthService());

  // Providers
  serviceLocator.registerLazySingleton(() => DatabaseProvider());

  // Controllers
  serviceLocator.registerLazySingleton<AuthController>(() => AuthController());

  //injeção de dependencia para o mapa
  //registrando o service do mapa no get it


  //registrando o controller e injetoando dependencia
  serviceLocator.registerLazySingleton(
      () => SpotControllerProvider(serviceLocator(), serviceLocator(), serviceLocator()));

  serviceLocator.registerLazySingleton(() => SpotSaveController(serviceLocator()));

  //instancia da entidade pico que será criada
}
