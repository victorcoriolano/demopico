
import 'package:demopico/features/mapa/data/models/pico_model.dart';

abstract class ISpotRepository {
  Future<void> createSpot(PicoModel pico);
  Future<List<PicoModel>> showAllPico();
  Future<void> salvarNota(PicoModel pico);


}