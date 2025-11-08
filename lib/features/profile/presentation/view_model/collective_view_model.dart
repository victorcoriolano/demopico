import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/profile/domain/usecases/accept_entry_on_collective_uc.dart';
import 'package:demopico/features/profile/domain/usecases/get_all_collectives_uc.dart';
import 'package:demopico/features/profile/domain/usecases/get_collective_by_id_uc.dart';
import 'package:demopico/features/profile/domain/usecases/get_collectives_for_profile_uc.dart';
import 'package:demopico/features/profile/domain/usecases/request_entry_on_collective_uc.dart';
import 'package:demopico/features/user/domain/usecases/get_users_by_ids.dart';
import 'package:flutter/material.dart';

class CollectiveViewModel extends ChangeNotifier {
  final GetCollectivesForProfileUc _getCollectivesForProfileUc;
  final GetCollectiveById _getTotalInformation;
  final GetAllCollectivesUc _getAllCollectivesUc;
  final GetUsersByIds _getUsersByIds;
  final RequestEntryOnCollectiveUc _requestEntryOnCollectiveUc;
  final AcceptEntryOnCollectiveUc _acceptEntryOnCollectiveUc;


  static CollectiveViewModel? _instance;
  static CollectiveViewModel get instance =>
    _instance ??= CollectiveViewModel(getColUC: GetCollectivesForProfileUc.instance, getColl: GetCollectiveById.instance);

  CollectiveViewModel({
    required GetCollectiveById getColl,
    required GetCollectivesForProfileUc getColUC 
  }): 
    _getCollectivesForProfileUc = getColUC, 
    _getTotalInformation = getColl,
    _getAllCollectivesUc = GetAllCollectivesUc(),
    _getUsersByIds = GetUsersByIds(),
    _requestEntryOnCollectiveUc = RequestEntryOnCollectiveUc(),
    _acceptEntryOnCollectiveUc = AcceptEntryOnCollectiveUc();

  List<ColetivoEntity> userCollectives = [];
  List<ColetivoEntity> allCollectives = [];
  
  late ColetivoEntity coletivo;
  bool isLoading = false;
  List<UserIdentification> requests = [];

  Future<void> getCollectives(String id) async {
    isLoading = true;
    notifyListeners();
    try {
      userCollectives = await _getCollectivesForProfileUc.execute(id);

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
      requests.clear();
      coletivo = await _getTotalInformation.execute(idCollective);
      fetchPendingRequests(coletivo.entryRequests);
    }on Failure catch (failure){
      FailureServer.showError(failure);
    } 
  }

  UserCollectiveRole checkUserRole(User user, ColetivoEntity coletivo){
    switch (user){
      case UserEntity():
        return coletivo.ruleForUser(user.id);
      case AnonymousUserEntity():
        return UserCollectiveRole.visitor;
    }
  }


  Future<void> getAllCollectives() async {
    isLoading = true;
    notifyListeners();
    try {
      if (allCollectives.isEmpty) allCollectives = await _getAllCollectivesUc.execute();
    } on Failure catch (e) {
      FailureServer.showError(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPendingRequests(List<String> ids) async {
    isLoading = true;
    notifyListeners();
    try {
      if (ids.isEmpty) return;
      if (requests.isEmpty) requests = await _getUsersByIds.execute(ids);
    } on Failure catch (e) {
      FailureServer.showError(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> requestEntry(UserIdentification user) async {
    try {
      coletivo = await _requestEntryOnCollectiveUc.execute(coletivo: coletivo, user: user);
      notifyListeners();
    } on Failure catch (e){
      FailureServer.showError(e);
    }
  }

  Future<void> acceptUserOnCollective(UserIdentification user) async {
    isLoading = true;
    notifyListeners();
    try {
      coletivo = await _acceptEntryOnCollectiveUc.execute(user, coletivo);
      notifyListeners();
    } on Failure catch (e) {
      FailureServer.showError(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


}