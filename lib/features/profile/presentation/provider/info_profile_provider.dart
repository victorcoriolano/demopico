/* import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/domain/usecases/update_data_user_uc.dart';
import 'package:demopico/features/user/presentation/controllers/user_data_view_model.dart';
import 'package:flutter/foundation.dart';

class InfoProfileProvider extends ChangeNotifier {
  static InfoProfileProvider? _profileProvider;

  static InfoProfileProvider get getInstance {
    _profileProvider ??=
        InfoProfileProvider(updateDataUserUc: UpdateDataUserUc.getInstance);
    return _profileProvider!;
  }

  final UpdateDataUserUc _updateDataUserUc;
  final UserDataViewModel _userDataViewModel;

  InfoProfileProvider(
      {required UpdateDataUserUc updateDataUserUc, required UserDataViewModel userDataViewModel})
      : _updateDataUserUc = updateDataUserUc,
        _userDataViewModel = UserDataViewModel.getInstance;
        

  

  Future<void> updateName(String name) async {
    final UserM? currentUser = _userDataViewModel.user;
    try {
      if (currentUser == null) {
        throw UnauthenticatedFailure();
      }
      _userDataViewModel.setUser = currentUser.copyWith(name: name);
      await _updateDataUserUc.call(_userDataViewModel.user!);
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
  }

  Future<void> updateBio(String bio) async {
    final UserM? currentUser = _userDataViewModel.user;
    try {
      if (currentUser == null) {
        throw UnauthenticatedFailure();
      }
      await _updateDataUserUc.call(currentUser!);
      _userDataViewModel.setUser = currentUser.copyWith(description: bio);
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
  }
}
 */