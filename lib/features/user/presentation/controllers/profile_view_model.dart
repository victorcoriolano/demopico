import 'package:demopico/features/profile/domain/models/profile_user.dart';
import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/user/domain/models/user_model.dart';
import 'package:demopico/features/user/domain/usecases/update_data_user_uc.dart';
import 'package:flutter/material.dart';
import 'package:demopico/features/user/domain/usecases/get_user_by_id.dart';

class ProfileViewModel extends ChangeNotifier {
  static ProfileViewModel? _userDatabaseProvider;
  static ProfileViewModel get getInstance {
    _userDatabaseProvider ??= ProfileViewModel(
        pegarDadosUserUc: GetUserByID.getInstance,
        updateDataUserUc: UpdateUserUc.getInstance);
    return _userDatabaseProvider!;
  }

  ProfileViewModel(
      {required this.pegarDadosUserUc,
      required UpdateUserUc updateDataUserUc})
;

  final GetUserByID pegarDadosUserUc;

  Profile? _currentProfile;
  Profile? get currentProfile => _currentProfile;

  Future<void> retrieveUserProfileData(String uid) async {
    try {
      // Retorna se os dados já foram pegos
      if (_currentProfile != null) {
        debugPrint("Retornando por que os dados do user já foram pegos");
        return;
      }
      debugPrint("pegando dados do usuario");
      //_currentProfile = await pegarDadosUserUc.execute(uid);
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
    notifyListeners();
  }

}
