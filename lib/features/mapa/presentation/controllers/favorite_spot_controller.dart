import 'package:demopico/features/mapa/domain/entities/pico_favorito.dart';
import 'package:demopico/features/mapa/domain/usecases/favorite_save_spot_uc.dart';
import 'package:demopico/features/mapa/presentation/dtos/spot_cart_ui_dto.dart';
import 'package:flutter/material.dart';

class FavoriteSpotController extends ChangeNotifier {
  static FavoriteSpotController? _spotSaveController;
  static FavoriteSpotController get getInstance {
    _spotSaveController ??=
        FavoriteSpotController(saveSpot: SaveSpotUc.getInstance);
    return _spotSaveController!;
  }

  final SaveSpotUc saveSpot;
  FavoriteSpotController({required this.saveSpot});

  List<SpotCardUIDto> picosFavoritos = [];
  String? error;
  Future<bool> savePico(PicoFavorito picoFav) async {
    final salvar = await saveSpot.saveSpot(picoFav);
    if (salvar) {
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }

  Future<void> getPicosSalvos(String idUser) async {
    try {
      debugPrint("Busca de picos salvos");
      picosFavoritos = await saveSpot.listFavoriteSpot(idUser);
      
    } on Exception catch (e) {
      error = "Um erro ao buscar picos salvos foi identificado: $e";
    } catch (e) {
      error = "Erro ao buscar picos salvos";
      
    }
  }

  Future<bool> deleteSave(String idPicoFavModel) async {
    try {
      await saveSpot.deleteSaveSpot(idPicoFavModel);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
