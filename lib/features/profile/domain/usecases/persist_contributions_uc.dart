import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_read_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_update_repository.dart';
import 'package:demopico/features/profile/infra/repository/profile_read_repository.dart';
import 'package:demopico/features/profile/infra/repository/profile_update_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:flutter/foundation.dart';

class PersistContributionsUc {
  static PersistContributionsUc? _persistContributionsUc;
  static PersistContributionsUc get getInstance {
    _persistContributionsUc ??= PersistContributionsUc(
      profileReadRepositoryIMP: ProfileReadRepository.getInstance,
      profileUpdateRepositoryIMP: ProfileUpdateRepository.getInstance,
    );
    return _persistContributionsUc!;
  }

  PersistContributionsUc({
    required this.profileReadRepositoryIMP,
    required this.profileUpdateRepositoryIMP,
  });

  final IProfileReadRepository profileReadRepositoryIMP;
  final IProfileUpdateRepository profileUpdateRepositoryIMP;

  void set(UserM user) {
    try {
      if (user.id == null) throw UserNotFoundFailure();
      profileUpdateRepositoryIMP.updateContributions(user);
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
      return await profileReadRepositoryIMP.getContributions(userModel);
    } on FirebaseException catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    } catch (e) {
      if (kDebugMode) print('Erro inesperado: $e');
      rethrow;
    }
  }
}
