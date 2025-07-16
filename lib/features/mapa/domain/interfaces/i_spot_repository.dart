
import 'package:demopico/features/mapa/domain/entities/filters.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';

abstract class ISpotRepository {
  Future<PicoModel> createSpot(PicoModel pico);
  Future<PicoModel> updateSpot(PicoModel pico);
  Stream<List<Pico>> loadSpots([Filters? filtro]);
  Future<PicoModel> getPicoByID(String id);
  Future<List<PicoModel>> getMySpots(String userID);
  Future<void> deleteSpot(String id);
}