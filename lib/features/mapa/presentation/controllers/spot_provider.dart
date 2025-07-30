import 'dart:async';

import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/enums/classification_spot.dart';
import 'package:demopico/features/mapa/domain/usecases/avaliar_spot_uc.dart';
import 'package:demopico/features/mapa/domain/usecases/watch_spot_uc.dart';
import 'package:flutter/material.dart';

class SpotProvider with ChangeNotifier {
  final WatchSpotUc _watchSpot;
  final AvaliarSpotUc _avaliarSpotUc;

  SpotProvider(
    {
      required WatchSpotUc watchUc,
      required AvaliarSpotUc avaliarUC,}
  )
  : _avaliarSpotUc = avaliarUC,
    _watchSpot = watchUc;

  // states
  // initial state for classification is respect
  ClassificationSpot classification = ClassificationSpot.respect;
  // error 
  String? error;
  //loading
  bool isLoading = false;
  //subscription for management of stream
  StreamSubscription? spotSubscription;
  //Spot in question 
  Pico? pico;
  
  void updateClassification(double rating){
    classification = ClassificationSpot.fromRate(rating);
    notifyListeners();
  }

  

  void initializeWatch(String idPico) {
    spotSubscription = _watchSpot.execute(idPico).listen(
      //on data
      (data){
        pico = data;
        notifyListeners();
      },
      onError: (error) {
        error = error.toString();

      }
    );
  }

  
  Future<void> avaliarSpot() async {
    isLoading = true;
    notifyListeners();
    if (pico == null){
      error = "Pico não identificado";
      return;
    }
    try {
      await _avaliarSpotUc.executar(pico!.id);
    }on Failure catch (e){
      error = e.message;
    }catch (e){
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  

}

