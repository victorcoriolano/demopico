import 'package:demopico/features/mapa/data/models/pico_model.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/user/data/models/user.dart';

abstract class ISaveSpotRepository {
    //save methods
  Future<void> saveSpot(PicoModel pico, UserM user);
  Future<List<Pico>> listSavePico(String idUser);
  Future<void> deleteSave(String userId, String picoName);
}