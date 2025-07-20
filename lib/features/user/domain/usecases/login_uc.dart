
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/user/domain/entity/user_credentials.dart';
import 'package:demopico/features/user/domain/enums/identifiers.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_auth_repository.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/user_auth_firebase_repository.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:flutter/foundation.dart';

class LoginUc {
  static LoginUc? _loginEmailUc;
  static LoginUc get getInstance {
    _loginEmailUc ??= LoginUc(
      userAuthRepository: UserAuthFirebaseRepository.getInstance,
      userDataRepository: UserDataRepositoryImpl.getInstance);
    return _loginEmailUc!;
  }

  final IUserAuthRepository userAuthRepository;
  final IUserDataRepository userDataRepository;

  LoginUc({required this.userAuthRepository, required this.userDataRepository});

  Future<UserM> logar(UserCredentialsSignIn credentials) async {
    
    try {
      if (credentials.identifier == Identifiers.vulgo){
        final email = await userDataRepository.getEmailByVulgo(credentials.login);
        credentials.setLogin(email);
      }
      final id = await userAuthRepository.login(credentials);
      return await userDataRepository.getUserDetailsByID(id);
    }on Failure catch (e, st) {
      debugPrint("Erro ao logar caiu no use case: $e, $st");
      rethrow;
    }
  }
}
