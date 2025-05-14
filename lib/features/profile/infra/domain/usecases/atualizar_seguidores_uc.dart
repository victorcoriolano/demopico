import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/profile/infra/domain/interfaces/i_profile_database_read_repository.dart';
import 'package:demopico/features/profile/infra/domain/interfaces/i_profile_database_update_repository.dart';
import 'package:demopico/features/profile/infra/infra/repository/profile_firebase_read_repository.dart';
import 'package:demopico/features/profile/infra/infra/repository/profile_firebase_update_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:flutter/foundation.dart';

class AtualizarSeguidoresUc {
  static AtualizarSeguidoresUc? _atualizarSeguidoresUc;
  static AtualizarSeguidoresUc get getInstance {
    _atualizarSeguidoresUc ??= AtualizarSeguidoresUc(
        profileDatabaseReadRepositoryIMP:
            ProfileFirebaseReadRepository.getInstance,
        profileDatabaseUpdateRepositoryIMP:
            ProfileFirebaseUpdateRepository.getInstance);
    return _atualizarSeguidoresUc!;
  }

  AtualizarSeguidoresUc(
      {required this.profileDatabaseReadRepositoryIMP,
      required this.profileDatabaseUpdateRepositoryIMP});

  final IProfileDatabaseReadRepository profileDatabaseReadRepositoryIMP;
  final IProfileDatabaseUpdateRepository profileDatabaseUpdateRepositoryIMP;

  void atualizar(UserM user) {
    try {
      if (user.id == null) throw UserNotFoundFailure();
      profileDatabaseUpdateRepositoryIMP.atualizarSeguidores(user);
    } on FirebaseException catch (e) {
      if (kDebugMode) print(e);
      throw FirebaseFailure();
    } catch (e) {
      if (kDebugMode) print('Erro inesperado: $e');
      throw GenericErrorFailure();
    }
  }

  Future<String> pegar() async {
    try {
      return await profileDatabaseReadRepositoryIMP.pegarSeguidores();
    } on FirebaseException catch (e) {
      if (kDebugMode) print(e);
      throw FirebaseFailure();
    } catch (e) {
      if (kDebugMode) print('Erro inesperado: $e');
      throw GenericErrorFailure();
    }
  }
}
