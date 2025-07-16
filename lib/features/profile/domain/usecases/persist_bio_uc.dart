import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_read_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_update_repository.dart';
import 'package:demopico/features/profile/infra/repository/profile_read_repository.dart';
import 'package:demopico/features/profile/infra/repository/profile_update_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:flutter/foundation.dart';

class PersistBioUc {
  static PersistBioUc? _persistBioUc;
  static PersistBioUc get getInstance {
    _persistBioUc ??= PersistBioUc(
      profileReadRepositoryIMP: ProfileReadRepository.getInstance,
      profileUpdateRepositoryIMP: ProfileUpdateRepository.getInstance,
    );
    return _persistBioUc!;
  }

  PersistBioUc({
    required this.profileReadRepositoryIMP,
    required this.profileUpdateRepositoryIMP,
  });

  final IProfileReadRepository profileReadRepositoryIMP;
  final IProfileUpdateRepository profileUpdateRepositoryIMP;

  void set(String newBio, UserM user) {
    try {
      
      profileUpdateRepositoryIMP.updateBio(newBio , user);
    } on FirebaseException catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    } on Failure catch (e) {
      if (kDebugMode) print('Erro inesperado: $e');
      rethrow;
    } catch (e) {
      throw UnknownFailure(unknownError: e);
    }
  }

  Future<String> get(UserM userModel) async {
    try {
      return await profileReadRepositoryIMP.getBio(userModel);
    } on FirebaseException catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    } catch (e) {
      if (kDebugMode) print('Erro inesperado: $e');
      throw Exception("Erro inesperado");
    }
  }
}
