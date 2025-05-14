import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> init() async {
  //espera todas as dependencias serem instanciadas?

  // Features - Auth

  //FirebaseAuth
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);

  //FirebaseFirestore
  serviceLocator.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Services
 // serviceLocator.registerFactory<DatabaseService>(() => DatabaseService());
  //.registerFactory<DatabaseService>(() => DatabaseService());

 // serviceLocator.registerLazySingleton<ISpotRepository>(() => FirebaseSpotsService(serviceLocator()));
 // serviceLocator.registerLazySingleton(() => FirebaseCommentService(serviceLocator()));
  

  // Providers serviceLocator.registerLazySingleton(() => DatabaseProvider());

  // Controllers  serviceLocator.registerLazySingleton<AuthController>(() => AuthController());
  //injeção de dependencia para o mapa
  //registrando o service do mapa no get it

 // serviceLocator.registerLazySingleton(() => CreateSpotUc(serviceLocator()));
  //serviceLocator.registerLazySingleton(() => SaveSpotUc(serviceLocator(), serviceLocator()));
 // serviceLocator.registerLazySingleton(() => LoadSpotUc(serviceLocator()));
 // serviceLocator.registerLazySingleton(() => AvaliarSpotUc(serviceLocator()));
  //registrando o controller e injetoando dependencia
//  serviceLocator.registerFactory(() => SpotControllerProvider(
//      serviceLocator(), serviceLocator(), serviceLocator()));

 // serviceLocator
 //     .registerLazySingleton(() => SpotSaveController(serviceLocator()));

  //instancia da entidade pico que será criada
}
