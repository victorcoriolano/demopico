import 'package:demopico/features/mapa/domain/entities/pico_favorito.dart';
import 'package:demopico/features/mapa/domain/usecases/favorite_save_spot_uc.dart';
import 'package:demopico/features/mapa/presentation/dtos/spot_cart_ui_dto.dart';
import 'package:flutter/material.dart';

class SpotSaveController extends ChangeNotifier {
  static SpotSaveController? _spotSaveController;
  static SpotSaveController get getInstance {
    _spotSaveController ??=
        SpotSaveController(saveSpot: SaveSpotUc.getInstance);
    return _spotSaveController!;
  }

  final SaveSpotUc saveSpot;
  SpotSaveController({required this.saveSpot});

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

  Future<bool> getPicosSalvos(String idUser) async {
    try {
      picosFavoritos = await saveSpot.listFavoriteSpot(idUser);
      if (picosFavoritos.isNotEmpty) {
        return true;
      } else {
        error = "Picos salvos não encontrados";
        return false;
      }
    } on Exception catch (e) {
      error = "Um erro ao buscar picos salvos foi identificado: $e";
      return false;
    } catch (e) {
      error = "Erro ao buscar picos salvos";
      return false;
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
