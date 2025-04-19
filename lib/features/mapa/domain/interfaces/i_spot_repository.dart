
import 'package:demopico/features/mapa/data/models/pico_model.dart';

abstract class ISpotRepository {
  Future<PicoModel?> createSpot(PicoModel pico);
  Future<List<PicoModel>> showAllPico();
  Future<PicoModel> salvarNota(PicoModel pico);
  Future<void> deleteSpot(String id);
}