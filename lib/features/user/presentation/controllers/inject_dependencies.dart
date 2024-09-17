import 'package:demopico/core/domain/usecases/login/login_use_case.dart';
import 'package:demopico/core/domain/usecases/login/sign_up_use_case.dart';
import 'package:demopico/features/user/data/external/firebase_auth.dart';
import 'package:demopico/features/user/data/services/auth_service.dart';
import 'package:demopico/features/user/data/services/firebase_service.dart';
import 'package:demopico/features/user/domain/interfaces/auth_interface.dart';
import 'package:demopico/features/user/presentation/controllers/provider_auth.dart';
import 'package:demopico/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

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

  // Repository
  
  serviceLocator.registerLazySingleton<AuthInterface>(() => AuthService(serviceLocator(), serviceLocator()));

  // Data Sources
  serviceLocator.registerLazySingleton(
      () => FirebaseService(serviceLocator(), serviceLocator()));

  // External
  final firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
}
