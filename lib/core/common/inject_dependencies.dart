
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/domain/usecases/login/login_use_case.dart';
import 'package:demopico/core/domain/usecases/login/sign_up_use_case.dart';
import 'package:demopico/features/mapa/data/services/firebase_service.dart';
import 'package:demopico/features/mapa/domain/interfaces/spot_repository.dart';
import 'package:demopico/features/mapa/domain/use%20cases/create_spot.dart';
import 'package:demopico/features/mapa/domain/use%20cases/show_all_pico.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_controller.dart';
import 'package:demopico/features/user/data/services/auth_service.dart';
import 'package:demopico/features/user/data/services/firebase_service.dart';
import 'package:demopico/features/user/presentation/controllers/login_controller.dart';
import 'package:demopico/features/user/presentation/controllers/provider_auth.dart';
import 'package:demopico/features/user/presentation/controllers/register_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> init() async {
  //espera todas as dependencias serem instanciadas?

  // Features - Auth
  // Providers
  //injetando instancias dos casos de uso no auth provider
  serviceLocator.registerFactory(() => ProviderAuth(
        loginUseCase: serviceLocator(),
        registerUseCase: serviceLocator(),
      ));
  // Use Cases
  //mapendo instancias dos caso de uso
  serviceLocator.registerLazySingleton(()  =>   LoginUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(()  => RegisterUseCase(serviceLocator()));

  //FirebaseAuth
  serviceLocator.registerLazySingleton(()  => FirebaseAuth.instance);

  //FirebaseFirestore
  serviceLocator.registerLazySingleton(()  => FirebaseFirestore.instance);

  // Services
  serviceLocator.registerFactory<FirebaseService>(
      () => FirebaseService(serviceLocator(), serviceLocator()));

  serviceLocator.registerLazySingleton<AuthService>(()  => AuthService(
      firebaseFirestore: serviceLocator(), firebaseService: serviceLocator()));

  // Controllers
  serviceLocator.registerLazySingleton<LoginController>(
      () => LoginController(authProvider: serviceLocator()));

  serviceLocator.registerFactory<RegisterController>(() => RegisterController());

  //injeção de dependencia para o mapa 
  //registrando o service do mapa no get it
  serviceLocator.registerLazySingleton<SpotRepository>(() => FirebaseServiceMap());
  //registrando os casos de uso e passando suas dependencias 
  //que já foram registradas na linha d cima
  //registrei como singleton por que não ira ter alteraçoes 
  //de estado nas instancias então vão todas ser iguais ent 
  //não precisa de várias instancias eu acho
  serviceLocator.registerLazySingleton(() => CreateSpot(serviceLocator()));
  serviceLocator.registerLazySingleton(() => ShowAllPico(serviceLocator()));

  //registrando o controller e injetoando dependencia
  serviceLocator.registerLazySingleton(() => SpotControllerProvider(serviceLocator(), serviceLocator()));


  //instancia da entidade pico que será criada 

}
