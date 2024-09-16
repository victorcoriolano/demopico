import 'package:demopico/core/domain/usecases/login/login_use_case.dart';
import 'package:demopico/core/domain/usecases/login/sign_up_use_case.dart';
import 'package:demopico/features/user/domain/interfaces/auth_interface.dart';
import 'package:demopico/features/user/presentation/controllers/provider_auth.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  // Features - Auth
  // Providers
  serviceLocator.registerFactory(() => ProviderAuth(
        loginUseCase: serviceLocator(),
        registerUseCase: serviceLocator(),
      ));

  // Use Cases
  serviceLocator.registerLazySingleton(() => LoginUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => RegisterUseCase(serviceLocator()));

  // Repository
  serviceLocator.registerLazySingleton<AuthInterface>(() => Auth(sl()));

  // Data Sources
  sl.registerLazySingleton(() => FirebaseAuthDataSource(sl()));

  // External
  final firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  sl.registerLazySingleton(() => FirebaseAuth.instance);
}
