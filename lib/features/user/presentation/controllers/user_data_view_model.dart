import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/domain/usecases/update_data_user_uc.dart';
import 'package:flutter/material.dart';
import 'package:demopico/features/user/domain/usecases/pegar_dados_user_uc.dart';

class UserDataViewModel extends ChangeNotifier {
  static UserDataViewModel? _userDatabaseProvider;
  static UserDataViewModel get getInstance {
    _userDatabaseProvider ??= UserDataViewModel(
        pegarDadosUserUc: PegarDadosUserUc.getInstance,
        updateDataUserUc: UpdateDataUserUc.getInstance);
    return _userDatabaseProvider!;
  }

  UserDataViewModel(
      {required this.pegarDadosUserUc,
      required UpdateDataUserUc updateDataUserUc})
      : _updateDataUserUc = updateDataUserUc;

  final PegarDadosUserUc pegarDadosUserUc;
  final UpdateDataUserUc _updateDataUserUc;

  UserM? _currentUser;
  UserM? get user => _currentUser;

  Future<void> retrieveUserProfileData(String uid) async {
    try {
      // Retorna se os dados já foram pegos
      if (_currentUser != null) {
        debugPrint("Retornando por que os dados do user já foram pegos");
        return;
      }
      debugPrint("pegando dados do usuario");
      _currentUser = await pegarDadosUserUc.getDados(uid);
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
    notifyListeners();
  }

  set setUser(UserM? authUser) {
    _currentUser = authUser;
  }
}
