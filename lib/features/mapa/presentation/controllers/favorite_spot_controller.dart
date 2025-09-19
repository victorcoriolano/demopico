import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/mapa/domain/usecases/favorite_save_spot_uc.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_provider.dart';
import 'package:demopico/features/mapa/presentation/dtos/spot_cart_ui_dto.dart';
import 'package:flutter/material.dart';

class FavoriteSpotController extends ChangeNotifier {
  static FavoriteSpotController? _spotSaveController;
  static FavoriteSpotController get getInstance {
    _spotSaveController ??=
        FavoriteSpotController(saveSpot: FavoriteSpotUC.getInstance);
    return _spotSaveController!;
  }

  FavoriteSpotController({required this.saveSpot});

  final FavoriteSpotUC saveSpot;

  bool isLoading = false;

  List<SpotCardUIDto> picosFavoritos = [];
  String? error;

  Future<void> favPico(String idUser) async {
    final pico = SpotProvider.instance.pico;
    if(pico == null){
      error = "Não foi possível identificar o Pico";
      return;
    } 
    try {
      await saveSpot.execute(pico, idUser);
    } on Failure catch (e) {
      debugPrint("Ocorreu um erro ao favoritar pico");
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
    } on DataNotFoundFailure catch (e) {
      isLoading = false;
      debugPrint("Documento inexistente: ${e.dataID}");
      error = e.message;
      notifyListeners();
    } on Failure catch (e){
      isLoading = false;
      debugPrint("CONTROLLER: ERRO AO BUSCAR PICOS FAVORITOS - $e ${e.runtimeType}");
      error = e.message;
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

  @override
  void dispose() {
    error = null;
    super.dispose();
  }
}
