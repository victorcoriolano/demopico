import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_auth_repository.dart';
import 'package:demopico/features/user/infra/repositories/user_auth_repository.dart';
import 'package:flutter/foundation.dart';

class LogoutUc {
  static LogoutUc? _logoutUc;
  static LogoutUc get getInstance {
  _logoutUc ??= LogoutUc(userAuthRepository: UserAuthRepository.getInstance);
    return _logoutUc!;
  }

  final IUserAuthRepository userAuthRepository;

  LogoutUc({required this.userAuthRepository});

  Future<void> deslogar() async {
    try {
      return await userAuthRepository.logout();
    }on Failure catch (e) {
      debugPrint("Erro ao deslogar tratado no usecase - relançando: $e");
      rethrow;
    }
  }
}
