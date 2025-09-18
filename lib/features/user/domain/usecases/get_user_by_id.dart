import 'package:demopico/core/common/auth/domain/interfaces/i_user_repository.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user_model.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:flutter/foundation.dart';

class GetUserByID {
  static GetUserByID? _pegarDadosUserUc;
  static GetUserByID get getInstance {
    _pegarDadosUserUc ??= GetUserByID(
      userDatabaseRepositoryIMP: UserDataRepositoryImpl.getInstance,
    );
    return _pegarDadosUserUc!;
  }

  final IUserRepository userDatabaseRepositoryIMP;

  GetUserByID({required this.userDatabaseRepositoryIMP});

  Future<UserM> getDados(String uid) async {
     try {
      return await userDatabaseRepositoryIMP.getById(uid);
    }on Failure catch (e) {
      debugPrint("Erro ao pegar dados do usuário tratado no use case: $e");
      rethrow;
    }
  }
}