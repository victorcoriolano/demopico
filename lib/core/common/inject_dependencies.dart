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
  // Features - Auth
  // Providers
  //injetando instancias dos casos de uso no auth provider
  serviceLocator.registerFactory(() => ProviderAuth(
        loginUseCase: serviceLocator(),
        registerUseCase: serviceLocator(),
      ));
  // Use Cases
  //mapendo instancias dos caso de uso
  serviceLocator.registerLazySingleton(() => LoginUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => RegisterUseCase(serviceLocator()));

  //FirebaseAuth
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);

  //FirebaseFirestore
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);

  // Services
  serviceLocator.registerLazySingleton<FirebaseService>(
      () => FirebaseService(serviceLocator(), serviceLocator()));
  serviceLocator.registerLazySingleton<AuthService>(() => AuthService(
      firebaseFirestore: serviceLocator(), firebaseService: serviceLocator()));

  // Controllers
  serviceLocator.registerLazySingleton<LoginController>(
      () => LoginController(authProvider: serviceLocator()));
}
