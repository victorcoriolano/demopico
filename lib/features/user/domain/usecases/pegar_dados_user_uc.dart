import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/user_firebase_repository.dart';
import 'package:flutter/foundation.dart';

class PegarDadosUserUc {
  static PegarDadosUserUc? _pegarDadosUserUc;
  static PegarDadosUserUc get getInstance {
    _pegarDadosUserUc ??= PegarDadosUserUc(
      userDatabaseRepositoryIMP: UserRepositoryImpl.getInstance,
    );
    return _pegarDadosUserUc!;
  }

  final IUserDatabaseRepository userDatabaseRepositoryIMP;

  PegarDadosUserUc({required this.userDatabaseRepositoryIMP});

  Future<UserM> getDados(String uid) async {
     try {
      return await userDatabaseRepositoryIMP.getUserDetails(uid);
    }on Failure catch (e) {
      debugPrint("Erro ao pegar dados do usuário tratado no use case: $e");
      rethrow;
    }
  }
}