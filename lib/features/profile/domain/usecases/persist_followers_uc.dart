import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_read_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_update_repository.dart';
import 'package:demopico/features/profile/infra/repository/profile_read_repository.dart';
import 'package:demopico/features/profile/infra/repository/profile_update_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:flutter/foundation.dart';

class PersistFollowersUc {
  static PersistFollowersUc? _persistFollowersUc;
  static PersistFollowersUc get getInstance {
    _persistFollowersUc ??= PersistFollowersUc(
        profileReadRepositoryIMP:
            ProfileReadRepository.getInstance,
        profileUpdateRepositoryIMP:
            ProfileUpdateRepository.getInstance);
    return _persistFollowersUc!;
  }

  PersistFollowersUc(
      {required this.profileReadRepositoryIMP,
      required this.profileUpdateRepositoryIMP});

  final IProfileReadRepository profileReadRepositoryIMP;
  final IProfileUpdateRepository profileUpdateRepositoryIMP;

  void set(UserM user) {
    try {
      profileUpdateRepositoryIMP.updateFollowers(user);
    } on FirebaseException catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    } catch (e) {
      if (kDebugMode) print('Erro inesperado: $e');
      rethrow;
    }
  }

  Future<int> get(UserM userModel) async {
    try {
      return await profileReadRepositoryIMP.getFollowers(userModel);
    } on FirebaseException catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    } catch (e) {
      if (kDebugMode) print('Erro inesperado: $e');
      rethrow;
    }
  }
}
