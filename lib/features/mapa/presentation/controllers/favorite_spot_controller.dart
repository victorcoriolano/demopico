import 'package:demopico/core/common/errors/failure_server.dart';
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

  FavoriteSpotController({required this.saveSpot});

  final SaveSpotUc saveSpot;

  bool isLoading = false;

  List<SpotCardUIDto> picosFavoritos = [];
  String? error;

  Future<void> savePico(PicoFavorito picoFav) async {
    try {
      await saveSpot.saveSpot(picoFav);
    } on Failure catch (e) {
      debugPrint("Ocorreu um erro ao salvar pico");
      error = e.message;
    }
  }

  Future<void> getPicosSalvos(String idUser) async {
    isLoading = true;
    picosFavoritos.clear();
    try {
      debugPrint("Busca de picos salvos");
      picosFavoritos.addAll(await saveSpot.listFavoriteSpot(idUser));
      debugPrint("Picos salvos: ${picosFavoritos.length}");
      isLoading = false;
      notifyListeners();
    } on Failure catch (e) {
      error = "Um erro ao buscar picos salvos foi identificado: $e";
      notifyListeners();
    }
  }

  Future<bool> deleteSave(String idPicoFavModel) async {
    try {
      await saveSpot.removeSaveSpot(idPicoFavModel);
      notifyListeners();
      return true;
    } catch (e) {
      error = e.toString();
      return false;
    }
  }
}
