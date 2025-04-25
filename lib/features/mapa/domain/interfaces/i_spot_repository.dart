
import 'package:demopico/features/mapa/domain/entities/filters.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';

abstract class ISpotRepository {
  Future<PicoModel?> createSpot(PicoModel pico);
  Future<PicoModel> salvarNota(PicoModel pico);
    Stream<List<PicoModel>> loadSpots(Filters? filtro);

  Future<void> deleteSpot(String id);
}