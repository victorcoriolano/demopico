import 'package:demopico/features/user/domain/entity/user_credentials.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_auth_repository.dart';
import 'package:demopico/features/user/infra/repositories/user_auth_firebase_repository.dart';

class LoginEmailUc {
  static LoginEmailUc? _loginEmailUc;
  static LoginEmailUc get getInstance {
    _loginEmailUc ??= LoginEmailUc(userAuthRepository: UserAuthFirebaseRepository.getInstance);
    return _loginEmailUc!;
  }

  final IUserAuthRepository userAuthRepository;

  LoginEmailUc({required this.userAuthRepository});

  Future<bool> logar(UserCredentialsSignIn credentials) async {
    try {
      return await userAuthRepository.loginByEmail(credentials);
    } catch (e) {
      return false;
    }
  }
}
