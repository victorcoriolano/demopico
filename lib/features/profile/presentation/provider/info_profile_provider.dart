import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/domain/usecases/update_data_user_uc.dart';
import 'package:flutter/foundation.dart';

class InfoProfileProvider extends ChangeNotifier {
  static InfoProfileProvider? _profileProvider;

  static InfoProfileProvider get getInstance {
    _profileProvider ??= InfoProfileProvider(
        updateDataUserUc: UpdateDataUserUc.getInstance
    );
    return _profileProvider!;
  }

  final UpdateDataUserUc _updateDataUserUc;
  InfoProfileProvider({required UpdateDataUserUc updateDataUserUc})
      : _updateDataUserUc = updateDataUserUc;

  
  Future<void> updateProfile(UserM user) async {
    try {
      await _updateDataUserUc.call(user);
    } catch (e) {
      debugPrint('Provider - ERROR: $e');
      rethrow;
    }
  }

}
