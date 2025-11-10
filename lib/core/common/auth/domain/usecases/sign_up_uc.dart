import 'package:demopico/core/common/auth/domain/entities/auth_result.dart';
import 'package:demopico/core/common/auth/domain/entities/user_credentials.dart';
import 'package:demopico/core/common/auth/domain/interfaces/i_auth_repository.dart';
import 'package:demopico/core/common/auth/infra/repositories/firebase_auth_repository.dart';

class SignUpUc {
  static SignUpUc? _instance;
  static SignUpUc get instance => _instance ??= SignUpUc(authRepository: FirebaseAuthRepository.instance);
  SignUpUc({
    required IAuthRepository authRepository,
  }): _authRepository = authRepository;

  final IAuthRepository _authRepository;

  Future<AuthResult> execute(NormalUserCredentialsSignUp credentials) {
    return _authRepository.signUp(credentials);
  }
}
