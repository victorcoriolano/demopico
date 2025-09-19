import 'package:demopico/core/common/auth/domain/entities/auth_result.dart';
import 'package:demopico/core/common/auth/domain/entities/user_credentials.dart';
import 'package:demopico/core/common/auth/domain/interfaces/i_auth_repository.dart';
import 'package:demopico/core/common/auth/infra/repositories/firebase_auth_repository.dart';

class SignInEmailPasswordUc {
  static SignInEmailPasswordUc? _instance;
  static SignInEmailPasswordUc get instance => _instance ??= SignInEmailPasswordUc(authRepository: FirebaseAuthRepository.instance);

  SignInEmailPasswordUc({
    required IAuthRepository authRepository,
  }): _authRepository = authRepository;

  final IAuthRepository _authRepository;

  Future<AuthResult> execute(EmailCredentialsSignIn credentials) async {
    return await _authRepository.signInWithEmail(credentials);
  }
}
