
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/user/data/models/loggeduser.dart';

abstract class SpotRepository {
  Future<void> createSpot(Pico pico);
  void saveSpot(Pico pico, LoggedUserModel user);
  Future<List<Pico>> showAllPico();
  Future<void> salvarNota(Pico pico);
}