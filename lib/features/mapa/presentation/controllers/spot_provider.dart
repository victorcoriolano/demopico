import 'dart:async';

import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/util/file_manager/delete_file_uc.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/enums/classification_spot.dart';
import 'package:demopico/features/mapa/domain/usecases/avaliar_spot_uc.dart';
import 'package:demopico/features/mapa/domain/usecases/delete_spot_uc.dart';
import 'package:demopico/features/mapa/domain/usecases/watch_spot_uc.dart';
import 'package:flutter/material.dart';

class SpotProvider with ChangeNotifier {
  final WatchSpotUc _watchSpot;
  final AvaliarSpotUc _avaliarSpotUc;
  final DeleteSpotUC _deleteSpotUC;
  final DeleteFileUc _deleteFileUc;

  static SpotProvider? _instance;
  static SpotProvider get instance => _instance ??= SpotProvider(
        deletefile: DeleteFileUc.instance,
        deleteUc: DeleteSpotUC.instance,
        watchUc: WatchSpotUc.instance,
        avaliarUC: AvaliarSpotUc.getInstance,
      );

  SpotProvider({
    required DeleteFileUc deletefile,
    required DeleteSpotUC deleteUc,
    required WatchSpotUc watchUc,
    required AvaliarSpotUc avaliarUC,
  })  : _avaliarSpotUc = avaliarUC,
        _watchSpot = watchUc,
        _deleteSpotUC = deleteUc,
        _deleteFileUc = deletefile;

  // states
  // initial state for classification is respect
  ClassificationSpot classification = ClassificationSpot.respect;
  double rate = 0;
  // error
  String? error;
  //loading
  bool isLoading = false;
  //subscription for management of stream
  StreamSubscription? spotSubscription;
  //Spot in question
  Pico? pico;

  void updateClassification(double rating) {
    classification = ClassificationSpot.fromRate(rating);
    rate = rating;
    notifyListeners();
  }

  void initializeWatch(String idPico) {
    isLoading = true;
    spotSubscription = _watchSpot.execute(idPico).listen(
        //on data
        
        (data) {
          pico = data;
          debugPrint("pico: $pico");
          isLoading = false;
          notifyListeners();
    }, onError: (error) {
      isLoading = false;
      error = error.toString();
    });
  }

  Future<void> avaliarSpot() async {
    isLoading = true;
    notifyListeners();
    if (pico == null) {
      error = "Pico não identificado";
      return;
    }
    try {
      await _avaliarSpotUc.executar(pico!, rate);
    } on Failure catch (e) {
      error = e.message;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deletarPico(Pico pico) async {
    try {
      await Future.wait([
        _deleteFileUc.deletarFile(pico.imgUrls),
        _deleteSpotUC.callDelete(pico.id),
      ]);
    } catch (e) {
      error = e.toString();
    }
  }
}
