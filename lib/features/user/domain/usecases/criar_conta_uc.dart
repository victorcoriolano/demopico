import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/user/domain/entity/user_credentials.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_auth_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/user_auth_firebase_repository.dart';
import 'package:flutter/foundation.dart';


class CriarContaUc {
  static CriarContaUc? _criarContaUc;
  static CriarContaUc get getInstance {
    _criarContaUc ??= CriarContaUc(
        userAuthRepositoryIMP: UserAuthFirebaseRepository.getInstance);
    return _criarContaUc!;
  }

  final IUserAuthRepository userAuthRepositoryIMP;


  CriarContaUc(
      {required this.userAuthRepositoryIMP});

  Future<UserM> criar(UserCredentialsSignUp credentials) async {
     if (credentials.password.length <= 7) throw InvalidPasswordFailure();
      if (!credentials.email.contains('@'))throw InvalidEmailFailure();
      if(credentials.nome.length <= 2) throw InvalidVulgoFailure();
    try {

      return await userAuthRepositoryIMP.signUp(credentials);
    } on Failure catch (e, st) {
      debugPrint("Ocorreu um erro conhecido ao criar usuário e caiu no use case: $e, $st");
      rethrow;
    }
  }
}
