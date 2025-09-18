import 'package:demopico/core/common/auth/domain/interfaces/i_auth_repository.dart';
import 'package:demopico/core/common/auth/infra/repositories/firebase_auth_repository.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:flutter/foundation.dart';

class LogoutUc {
  static LogoutUc? _logoutUc;
  static LogoutUc get getInstance {
  _logoutUc ??= LogoutUc(userAuthRepository: FirebaseAuthRepository.instance);
    return _logoutUc!;
  }

  final IAuthRepository userAuthRepository;

  LogoutUc({required this.userAuthRepository});

  Future<void>  deslogar() async {
    try {
      return await userAuthRepository.signOut();
    }on Failure catch (e) {
      debugPrint("Erro ao deslogar tratado no usecase - relançando: $e");
      rethrow;
    } catch (e){
      debugPrint("Erro não tratado: $e");
      throw(UnknownFailure(unknownError: e));
    }
  }
}
