import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/domain/usecases/update_data_user_uc.dart';
import 'package:flutter/foundation.dart';

class InfoProfileProvider extends ChangeNotifier {
  static InfoProfileProvider? _profileProvider;

  static InfoProfileProvider get getInstance {
    _profileProvider ??=
        InfoProfileProvider(updateDataUserUc: UpdateDataUserUc.getInstance);
    return _profileProvider!;
  }

  final UpdateDataUserUc _updateDataUserUc;
  UserM? _currentUser;

  InfoProfileProvider(
      {required UpdateDataUserUc updateDataUserUc, UserM? currentUser})
      : _updateDataUserUc = updateDataUserUc,
        _currentUser = currentUser;

  Future<void> updateName(String name) async {
    try {
      if (_currentUser == null) {
        throw UnauthenticatedFailure();
      }
      _currentUser = _currentUser!.copyWith(name: name);
      await _updateDataUserUc.call(_currentUser!);
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
  }

  Future<void> updateBio(String bio) async {
    try {
      if (_currentUser == null) {
        throw UnauthenticatedFailure();
      }
      _currentUser = _currentUser!.copyWith(description: bio);
      await _updateDataUserUc.call(_currentUser!);
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
  }
}
