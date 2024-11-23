
import 'package:demopico/core/domain/entities/user_profile.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';

abstract class SpotRepository {
  Future<void> createSpot(Pico pico);
  void saveSpot(Pico pico, LoggedUser user);
  Future<List<Pico>> showAllPico();
  Future<void> salvarNota(int avaliacoes, double nota);
}