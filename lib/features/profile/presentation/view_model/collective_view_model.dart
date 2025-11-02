import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/profile/domain/usecases/get_collective_by_id_uc.dart';
import 'package:demopico/features/profile/domain/usecases/get_collectives_for_profile_uc.dart';
import 'package:flutter/material.dart';

class CollectiveViewModel extends ChangeNotifier {
  final GetCollectivesForProfileUc _getCollectivesForProfileUc;
  final GetCollectiveById _getTotalInformation;

    static CollectiveViewModel? _instance;
    static CollectiveViewModel get instance =>
      _instance ??= CollectiveViewModel(getColUC: GetCollectivesForProfileUc.instance, getColl: GetCollectiveById.instance);

  CollectiveViewModel({
    required GetCollectiveById getColl,
    required GetCollectivesForProfileUc getColUC 
  }): _getCollectivesForProfileUc = getColUC, _getTotalInformation = getColl;

  List<ColetivoEntity> collectives = [];
  late ColetivoEntity coletivo;
  bool isLoading = false;

  Future<void> getCollectives(String id) async {
    isLoading = true;
    notifyListeners();
    try {
      collectives = await _getCollectivesForProfileUc.execute(id);

    }on Failure catch (failure) {
      FailureServer.showError(failure);
    }
    finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getTotalInformationCollective(String idCollective) async {
    try {
      coletivo = await _getTotalInformation.execute(idCollective);
    }on Failure catch (failure){
      FailureServer.showError(failure);
    } 
  }
}