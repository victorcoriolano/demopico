import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_database_read_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_database_update_repository.dart';
import 'package:demopico/features/profile/infra/repository/profile_firebase_read_repository.dart';
import 'package:demopico/features/profile/infra/repository/profile_firebase_update_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:flutter/foundation.dart';

class AtualizarFotoUc {
  static AtualizarFotoUc? _atualizarFotoUc;
  static AtualizarFotoUc get getInstance {
    _atualizarFotoUc ??= AtualizarFotoUc(
      profileDatabaseReadRepositoryIMP: ProfileFirebaseReadRepository.getInstance,
      profileDatabaseUpdateRepositoryIMP: ProfileFirebaseUpdateRepository.getInstance,
    );
    return _atualizarFotoUc!;
  }

  AtualizarFotoUc({
    required this.profileDatabaseReadRepositoryIMP,
    required this.profileDatabaseUpdateRepositoryIMP,
  });

  final IProfileDatabaseReadRepository profileDatabaseReadRepositoryIMP;
  final IProfileDatabaseUpdateRepository profileDatabaseUpdateRepositoryIMP;

  void atualizar(String newFoto, UserM user) {
    try {
      if (user.id == null) throw UserNotFoundFailure();
      profileDatabaseUpdateRepositoryIMP.atualizarFoto(newFoto, user);
    } on FirebaseException catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    } catch (e) {
      if (kDebugMode) print('Erro inesperado: $e');
      rethrow;
    }
  }

  Future<String> pegar(String uid) async {
    try {
      return await profileDatabaseReadRepositoryIMP.pegarFoto(uid);
    } on FirebaseException catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    } catch (e) {
      if (kDebugMode) print('Erro inesperado: $e');
      rethrow;
    }
  }
}
