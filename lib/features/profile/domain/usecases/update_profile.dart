import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:flutter/foundation.dart';

class UpdateProfile {
  final IUserDataRepository _userDataRepository;

  UpdateProfile({required IUserDataRepository userDataRepository})
      : _userDataRepository = userDataRepository;

  Future<void> updateProfile(UserM user) async {
    try {
      await _userDataRepository.updateUserDetails(user);
    } on Failure catch (e) {
      debugPrint('UC - ERROR KNOWN: $e');
      rethrow;
    } catch (e) {
      debugPrint('UC - ERROR UNKNOWN: $e');
      throw UnknownFailure(unknownError: e);
    }
  }
}