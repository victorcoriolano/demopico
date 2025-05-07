import 'package:demopico/features/mapa/domain/entities/pico_favorito.dart';
import 'package:demopico/features/mapa/domain/usecases/favorite_save_spot_uc.dart';
import 'package:demopico/features/mapa/presentation/dtos/spot_cart_ui.dart';
import 'package:flutter/material.dart';

class SpotSaveController extends ChangeNotifier {
  final SaveSpotUc saveSpot;
  SpotSaveController(this.saveSpot);

  List<SpotCardUi> picosFavoritos = [];
  String? error;
  Future<bool> savePico(PicoFavorito picoFav) async {
    final salvar = await saveSpot.saveSpot(picoFav);
    if (salvar) {
      notifyListeners();
      return true;
    } else {
      print("Não foi possivel salvar");
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
      print("object deleted sucess");
      return true;
    } catch (e) {
      print("Erro ao del: $e");
      return false;
    }
  }
}
