
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SpotRepository {
  Future<void> createSpot(Pico pico);
  Future<List<Pico>> showAllPico();
  Future<void> salvarNota(Pico pico);

  //save methods
  Future<void> saveSpot(Pico pico, User user);
  Future<List<Pico>> getSavePico(String idUser);
  Future<void> deleteSave(String userId, String picoName);
}