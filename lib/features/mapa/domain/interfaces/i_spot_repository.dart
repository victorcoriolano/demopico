
import 'package:demopico/features/mapa/domain/entities/filters.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';

abstract class ISpotRepository {
  
  Future<PicoModel> createSpot(PicoModel pico);
  Future<PicoModel> updateSpot(PicoModel pico);
  Future<void> evaluateSpot(PicoModel idSpot, double newRating);
  Stream<List<PicoModel>> watchListSpots([Filters? filtro]);
  Stream<PicoModel> watchSpot(String id);
  Future<PicoModel> getPicoByID(String id);
  Future<List<PicoModel>> getMySpots(String userID);
  Future<void> deleteSpot(String id);
}