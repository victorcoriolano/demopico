import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/spot_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServiceasAService implements SpotRepository {
  @override
  Future<void> createSpot(Pico pico) {
    print("buceta");
    return Future.value(null);
  }

  @override
  Future<void> deleteSave(String userId, String picoName) {
    // TODO: implement deleteSave
    throw UnimplementedError();
  }

  @override
  Future<List<Pico>> getSavePico(String idUser) {
    // TODO: implement getSavePico
    throw UnimplementedError();
  }

  @override
  Future<void> salvarNota(Pico pico) {
    // TODO: implement salvarNota
    throw UnimplementedError();
  }

  @override
  Future<void> saveSpot(Pico pico, User user) {
    // TODO: implement saveSpot
    throw UnimplementedError();
  }

  @override
  Future<List<Pico>> showAllPico() {
    // TODO: implement showAllPico
    throw UnimplementedError();
  }
}
