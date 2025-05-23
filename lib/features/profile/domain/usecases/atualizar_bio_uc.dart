import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_database_read_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_database_update_repository.dart';
import 'package:demopico/features/profile/infra/repository/profile_read_repository.dart';
import 'package:demopico/features/profile/infra/repository/profile_update_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:flutter/foundation.dart';

class AtualizarBioUc {
  static AtualizarBioUc? _atualizarBioUc;
  static AtualizarBioUc get getInstance {
    _atualizarBioUc ??= AtualizarBioUc(
      profileReadRepositoryIMP: ProfileReadRepository.getInstance,
      profileUpdateRepositoryIMP: ProfileUpdateRepository.getInstance,
    );
    return _atualizarBioUc!;
  }

  AtualizarBioUc({
    required this.profileReadRepositoryIMP,
    required this.profileUpdateRepositoryIMP,
  });

  final IProfileReadRepository profileReadRepositoryIMP;
  final IProfileUpdateRepository profileUpdateRepositoryIMP;

  void atualizar(String newBio, UserM user) {
    try {
      if (user.id == null) throw UserNotFoundFailure();
      profileUpdateRepositoryIMP.atualizarBio(newBio , user);
    } on FirebaseException catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    } catch (e) {
      if (kDebugMode) print('Erro inesperado: $e');
      rethrow;
    }
  }

  Future<String> pegar(UserM userModel) async {
    try {
      return await profileReadRepositoryIMP.pegarBio(userModel);
    } on FirebaseException catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    } catch (e) {
      if (kDebugMode) print('Erro inesperado: $e');
      throw Exception("Erro inesperado");
    }
  }
}
