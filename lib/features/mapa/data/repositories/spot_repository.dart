import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';

abstract class ISpotRepository {
  Future<List<Pico>> findAll();
  Future<void> savePico(Pico pico);
}
