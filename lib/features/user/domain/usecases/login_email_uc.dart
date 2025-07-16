import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/user/domain/entity/user_credentials.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_auth_repository.dart';
import 'package:demopico/features/user/infra/repositories/user_auth_firebase_repository.dart';
import 'package:flutter/foundation.dart';

class LoginEmailUc {
  static LoginEmailUc? _loginEmailUc;
  static LoginEmailUc get getInstance {
    _loginEmailUc ??= LoginEmailUc(userAuthRepository: UserAuthFirebaseRepository.getInstance);
    return _loginEmailUc!;
  }

  final IUserAuthRepository userAuthRepository;

  LoginEmailUc({required this.userAuthRepository});

  Future<void> logar(UserCredentialsSignIn credentials) async {
    try {
      await userAuthRepository.loginByEmail(credentials);
    }on Failure catch (e, st) {
      debugPrint("Erro ao logar caiu no use case: $e, $st");
      rethrow;
    }
  }
}
