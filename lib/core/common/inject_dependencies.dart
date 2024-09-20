import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/domain/usecases/login/login_use_case.dart';
import 'package:demopico/core/domain/usecases/login/sign_up_use_case.dart';
import 'package:demopico/features/user/data/services/auth_service.dart';
import 'package:demopico/features/user/data/services/firebase_service.dart';
import 'package:demopico/features/user/presentation/controllers/login_controller.dart';
import 'package:demopico/features/user/presentation/controllers/provider_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> init() async {
  //espera todas as dependencias serem instanciadas?
  await serviceLocator.allReady();
  // Features - Auth
  // Providers
  //injetando instancias dos casos de uso no auth provider
  serviceLocator.registerFactoryAsync(() async => ProviderAuth(
        loginUseCase: serviceLocator(),
        registerUseCase: serviceLocator(),
      ));
  // Use Cases
  //mapendo instancias dos caso de uso
  serviceLocator.registerLazySingletonAsync(() async =>   LoginUseCase(serviceLocator()));
  serviceLocator.registerLazySingletonAsync(() async => RegisterUseCase(serviceLocator()));

  //FirebaseAuth
  serviceLocator.registerLazySingletonAsync(() async => FirebaseAuth.instance);

  //FirebaseFirestore
  serviceLocator.registerLazySingletonAsync(() async => FirebaseFirestore.instance);

  // Services
  serviceLocator.registerLazySingletonAsync<FirebaseService>(
      () async => FirebaseService(serviceLocator(), serviceLocator()));
  serviceLocator.registerLazySingletonAsync<AuthService>(() async => AuthService(
      firebaseFirestore: serviceLocator(), firebaseService: serviceLocator()));

  // Controllers
serviceLocator.registerLazySingletonAsync<LoginController>(
      () async=> LoginController(authProvider: serviceLocator()));
}
