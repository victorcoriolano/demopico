import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/usecases/save_spot_uc.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:flutter/material.dart';

class SpotSaveController extends ChangeNotifier {
  final SaveSpotUc saveSpot;
  SpotSaveController(this.saveSpot);

  List<Pico> picosSalvos = [];
  Future<bool> savePico(Pico pico, UserM user) async {
    final salvar = await saveSpot.saveSpot(pico, user);
    if (salvar) {
      picosSalvos.add(pico);
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
      picosSalvos = await saveSpot.listPicoUC(idUser);
      print("Picos salvos: $picosSalvos");
      if (picosSalvos.isNotEmpty) {
        return true;
      } else {
        print("Nenhum pico encontrado para ester user");
        return false;
      }
    } on Exception catch (e) {
      // TODO
      print("Erro ao pegar picos salvos: $e");
      return false;
    } catch (e) {
      print("Erro sla: $e");
      return false;
    }
  }

  Future<bool> deleteSave(String namePico, String userId) async {
    try {
      await saveSpot.deleteSaveSpot(userId, namePico);
      final index =
          picosSalvos.indexWhere((picoSalvo) => picoSalvo.picoName == namePico);
      picosSalvos.removeAt(index);
      notifyListeners();
      print("object deleted sucess");
      return true;
    } catch (e) {
      print("Erro ao del: $e");
      return false;
    }
  }
}
