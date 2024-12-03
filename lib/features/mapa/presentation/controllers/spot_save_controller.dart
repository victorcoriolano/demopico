import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/use%20cases/save_spot.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SpotSaveController extends ChangeNotifier {
  final SaveSpot saveSpot;
  SpotSaveController(this.saveSpot);

  final List<Pico> picosSalvos = [];
  Future<bool> savePico(Pico pico, User user)async{
    final salvar  = await saveSpot.saveSpot(pico, user);
    if(salvar){
      picosSalvos.add(pico);
      notifyListeners();
      return true;
    }else{
      print("Não foi possivel salvar");
      notifyListeners();
      return false;
    }
    
    
  }

  Future<void> getPicosSalvos(String idUser)async{
    final listPicoFromDB = await saveSpot.executeUseCase(idUser);
    picosSalvos.addAll(listPicoFromDB);
  }
}