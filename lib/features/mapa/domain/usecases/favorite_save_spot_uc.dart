import 'package:demopico/features/mapa/data/services/firebase_favorite_spot_service.dart';
import 'package:demopico/features/mapa/data/services/firebase_spots_service.dart';
import 'package:demopico/features/mapa/domain/entities/pico_favorito.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_favorite_spot_repository.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';
import 'package:demopico/features/mapa/presentation/dtos/spot_cart_ui_dto.dart';

class SaveSpotUc {
  static SaveSpotUc? _saveSpotUc;
  static get getInstance {
    _saveSpotUc ??= SaveSpotUc(
        spotFavRepositoryIMP: FirebaseFavoriteSpotService.getInstance,
        spotRepositoryIMP: FirebaseSpotsService.getInstance);
    return _saveSpotUc!;
  }

  final IFavoriteSpotRepository spotFavRepositoryIMP;
  final ISpotRepository spotRepositoryIMP;

  SaveSpotUc(
      {required this.spotFavRepositoryIMP, required this.spotRepositoryIMP});

  Future<bool> saveSpot(PicoFavorito picoFav) async {
    try {
      await spotFavRepositoryIMP.saveSpot(picoFav);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<SpotCardUIDto>> listFavoriteSpot(String idUser) async {
    try {
      final favoritos = await spotFavRepositoryIMP.listFavoriteSpot(idUser);
      if (favoritos.isEmpty) {
        throw Exception("Picos salvos não encontrados");
      }
      final result = await Future.wait(favoritos.map((fav) async {
        final pico =
            await spotRepositoryIMP.getPicoByID(fav.id); // retorna PicoModel
        var card = SpotCardUIDto(picoFavoritoModel: fav, picoModel: pico);
        return card;
      }));
      return result;
    } catch (e) {
      return [];
    }
  }

  Future<void> deleteSaveSpot(String idPicoFavModel) async {
    try {
      await spotFavRepositoryIMP.deleteSave(idPicoFavModel);
    } catch (e) {
      throw Exception("Erro ao deletar o pico favorito: $e");
    }
  }
}
