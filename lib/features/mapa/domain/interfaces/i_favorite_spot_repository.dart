import 'package:demopico/features/mapa/domain/entities/pico_favorito.dart';
import 'package:demopico/features/mapa/domain/models/pico_favorito_model.dart';

abstract class IFavoriteSpotRepository {
  //save methods
  Future<PicoFavoritoModel> saveSpot(PicoFavorito pico);
  Future<List<PicoFavoritoModel>> listFavoriteSpot(String idUser);
  Future<void> deleteSave(String id);
}