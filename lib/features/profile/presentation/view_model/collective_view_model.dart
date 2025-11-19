import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:demopico/core/common/media_management/services/upload_service.dart';
import 'package:demopico/features/profile/domain/usecases/accept_entry_on_collective_uc.dart';
import 'package:demopico/features/profile/domain/usecases/delete_collective_uc.dart';
import 'package:demopico/features/profile/domain/usecases/get_all_collectives_uc.dart';
import 'package:demopico/features/profile/domain/usecases/get_collective_by_id_uc.dart';
import 'package:demopico/features/profile/domain/usecases/get_collectives_for_profile_uc.dart';
import 'package:demopico/features/profile/domain/usecases/refuse_entry_request_uc.dart';
import 'package:demopico/features/profile/domain/usecases/remove_member_uc.dart';
import 'package:demopico/features/profile/domain/usecases/request_entry_on_collective_uc.dart';
import 'package:demopico/features/profile/domain/usecases/update_collective_uc.dart';
import 'package:demopico/features/user/domain/usecases/get_users_by_ids.dart';
import 'package:flutter/material.dart';

class CollectiveViewModel extends ChangeNotifier {
  final GetCollectivesForProfileUc _getCollectivesForProfileUc;
  final GetCollectiveById _getTotalInformation;
  final GetAllCollectivesUc _getAllCollectivesUc;
  final GetUsersByIds _getUsersByIds;
  final RequestEntryOnCollectiveUc _requestEntryOnCollectiveUc;
  final AcceptEntryOnCollectiveUc _acceptEntryOnCollectiveUc;
  final UpdateCollectiveUc _updateCollectiveUc;
  final RefuseEntryRequestUseCase _refuseEntryRequestUseCase;
  final RemoveMemberUseCase _removeMemberUseCase;
  final DeleteCollectiveUc _deleteCollectiveUc;

  static CollectiveViewModel? _instance;
  static CollectiveViewModel get instance =>
      _instance ??= CollectiveViewModel();

  CollectiveViewModel()
      : _getCollectivesForProfileUc = GetCollectivesForProfileUc.instance,
        _getTotalInformation = GetCollectiveById.instance,
        _getAllCollectivesUc = GetAllCollectivesUc(),
        _getUsersByIds = GetUsersByIds(),
        _requestEntryOnCollectiveUc = RequestEntryOnCollectiveUc(),
        _acceptEntryOnCollectiveUc = AcceptEntryOnCollectiveUc(),
        _updateCollectiveUc = UpdateCollectiveUc(),
        _refuseEntryRequestUseCase = RefuseEntryRequestUseCase(),
        _removeMemberUseCase = RemoveMemberUseCase(),
        _deleteCollectiveUc = DeleteCollectiveUc.instance;

  List<ColetivoEntity> userCollectives = [];
  List<ColetivoEntity> allCollectives = [];

  late ColetivoEntity coletivo;
  bool isLoading = false;
  List<UserIdentification> requests = [];
  List<UserIdentification> members = [];

  Future<void> getCollectivesForUser(String id) async {
    isLoading = true;
    notifyListeners();
    try {
      userCollectives = await _getCollectivesForProfileUc.execute(id);
    } on Failure catch (failure) {
      FailureServer.showError(failure);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getTotalInformationCollective(String idCollective) async {
    try {
      requests.clear();
      coletivo = await _getTotalInformation.execute(idCollective);
      members = coletivo.members;
      notifyListeners();
    } on Failure catch (failure) {
      debugPrint("Erro ao pegar as informações do coletivo: $failure");
      FailureServer.showError(failure);
    }
  }

  UserCollectiveRole checkUserRole(User user, ColetivoEntity coletivo) {
    switch (user) {
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
      if (allCollectives.isNotEmpty) return;
      allCollectives = await _getAllCollectivesUc.execute();
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
      coletivo = await _requestEntryOnCollectiveUc.execute(
          coletivo: coletivo, user: user);
      notifyListeners();
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
  }

  Future<void> acceptUserOnCollective(UserIdentification user) async {
    isLoading = true;
    notifyListeners();
    try {
      coletivo = await _acceptEntryOnCollectiveUc.execute(user, coletivo);
      requests.remove(user); // atualização rápida pra retorno instantâneo na view
      members.add(user);     // idem
      notifyListeners();
    } on Failure catch (e) {
      FailureServer.showError(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateCollective({
    required String id,
    required String name,
    FileModel? background,
    FileModel? insignia,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      final urlBaground = background != null
          ? await UploadService.getInstance.uploadAFileWithoutStream(
              background, 'collectives/backgrounds/$id')
          : null;
      final urlInsignia = insignia != null
          ? await UploadService.getInstance
              .uploadAFileWithoutStream(insignia, 'collectives/insignias/$id')
          : null;

      coletivo = coletivo.copyWith(
          backgroundPicture: urlBaground,
          logo: urlInsignia,
          nameColetivo: name);
      await _updateCollectiveUc.execute(coletivo);
      notifyListeners();
    } on Failure catch (failure) {
      FailureServer.showError(failure);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refuseUserOnCollective(String userId) async {
    isLoading = true;
    notifyListeners();
    try {
      coletivo = await _refuseEntryRequestUseCase.execute(
          userId: userId, coletivo: coletivo);
      requests.removeWhere((element) => element.id == userId);
      notifyListeners();
    } on Failure catch (failure) {
      FailureServer.showError(failure);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> removeMember(UserIdentification user) async {
    isLoading = true;
    notifyListeners();
    try {
      coletivo = await _removeMemberUseCase.execute(user: user, coletivo: coletivo);
      members.remove(user);
      notifyListeners();
    } on Failure catch (e) {
      FailureServer.showError(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  
Future<void> deleteCollective(ColetivoEntity coletivo) async {
    isLoading = true;
    notifyListeners();
    try {
      await _deleteCollectiveUc.execute(coletivo);
      userCollectives.removeWhere((c) => c.id == coletivo.id);
      notifyListeners();
    } on Failure catch (e) {
      FailureServer.showError(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
