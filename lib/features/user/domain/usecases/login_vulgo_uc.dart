import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/user/domain/entity/user_credentials.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_auth_repository.dart';
import 'package:demopico/features/user/infra/repositories/user_auth_firebase_repository.dart';
import 'package:flutter/foundation.dart';

class LoginVulgoUc {
  static LoginVulgoUc? _loginVulgoUc;
  static LoginVulgoUc get getInstance {
    _loginVulgoUc ??= LoginVulgoUc(userAuthRepository: UserAuthFirebaseRepository.getInstance);
    return _loginVulgoUc!;
  }

  final IUserAuthRepository userAuthRepository;

  LoginVulgoUc({required this.userAuthRepository});

  Future<void> logar(UserCredentialsSignInVulgo userCredential) async {
    try {
      return await userAuthRepository.loginByVulgo(userCredential);
    }on Failure catch (e) {
      debugPrint("Erro ao logar por Vulgo: $e");
      rethrow;
    }
  }
}
