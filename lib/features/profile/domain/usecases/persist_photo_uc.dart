import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_read_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_update_repository.dart';
import 'package:demopico/features/profile/infra/repository/profile_read_repository.dart';
import 'package:demopico/features/profile/infra/repository/profile_update_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:flutter/foundation.dart';

class PersistPhotoUc {
  static PersistPhotoUc? _persistPhotoUc;
  static PersistPhotoUc get getInstance {
    _persistPhotoUc ??= PersistPhotoUc(
      profileReadRepositoryIMP: ProfileReadRepository.getInstance,
      profileUpdateRepositoryIMP: ProfileUpdateRepository.getInstance,
    );
    return _persistPhotoUc!;
  }

  PersistPhotoUc({
    required this.profileReadRepositoryIMP,
    required this.profileUpdateRepositoryIMP,
  });

  final IProfileReadRepository profileReadRepositoryIMP;
  final IProfileUpdateRepository profileUpdateRepositoryIMP;

  void set(String newFoto, UserM user) {
    try {
      if (user.id == null) throw UserNotFoundFailure();
      profileUpdateRepositoryIMP.updatePhoto(newFoto, user);
    } on FirebaseException catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    } catch (e) {
      if (kDebugMode) print('Erro inesperado: $e');
      rethrow;
    }
  }

  Future<String> get(UserM userModel) async {
    try {
      return await profileReadRepositoryIMP.getPhoto(userModel);
    } on FirebaseException catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    } catch (e) {
      if (kDebugMode) print('Erro inesperado: $e');
      rethrow;
    }
  }
}
