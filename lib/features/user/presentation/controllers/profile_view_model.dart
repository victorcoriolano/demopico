import 'package:demopico/features/profile/domain/models/profile_user.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/user/domain/usecases/update_data_user_uc.dart';
import 'package:flutter/material.dart';
import 'package:demopico/features/user/domain/usecases/get_profile_user_by_id.dart';

class ProfileViewModel extends ChangeNotifier {
  static ProfileViewModel? _userDatabaseProvider;
  static ProfileViewModel get getInstance {
    _userDatabaseProvider ??= ProfileViewModel(
        pegarDadosUserUc: GetProfileUserByID.getInstance,
        updateDataUserUc: UpdateUserUc.getInstance);
    return _userDatabaseProvider!;
  }

  ProfileViewModel(
      {required this.pegarDadosUserUc,
      required UpdateUserUc updateDataUserUc})
;

  final GetProfileUserByID pegarDadosUserUc;

  Profile _currentProfile = Profile.empty;
  Profile get currentProfile => _currentProfile;

  Future<void> fetchProfileDataByID(String uid) async {
    // Retorna se os dados já foram pegos  
    debugPrint("pegando dados do usuario");
    final result = await pegarDadosUserUc.execute(uid);
    if (result.success){
      _currentProfile = result.profile!;
    }else  {
      FailureServer.showError(result.failure!);
    }
    notifyListeners();
  }

}
