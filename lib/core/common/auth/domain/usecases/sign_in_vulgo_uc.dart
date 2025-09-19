import 'package:demopico/core/common/auth/domain/entities/auth_result.dart';
import 'package:demopico/core/common/auth/domain/entities/user_credentials.dart';
import 'package:demopico/core/common/auth/domain/interfaces/i_auth_repository.dart';
import 'package:demopico/core/common/auth/domain/interfaces/i_user_repository.dart';
import 'package:demopico/core/common/auth/infra/repositories/firebase_auth_repository.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';

class SignInVulgoUc {
  static SignInVulgoUc? _instance;
  static SignInVulgoUc get instance => 
    _instance ??= SignInVulgoUc(
      authRepository: FirebaseAuthRepository.instance,
      userRepository: UserDataRepositoryImpl.getInstance);

  SignInVulgoUc({
    required IAuthRepository authRepository,
    required IUserRepository userRepository,
  }): _authRepository = authRepository,
      _userRepository = userRepository;

  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;

  Future<AuthResult> execute(VulgoCredentialsSignIn credentials) async {
    final emailUser = await _userRepository.getEmailByVulgo(credentials.vulgo);
    return await _authRepository.signInWithEmail(EmailCredentialsSignIn(identifier: emailUser, senha: credentials.password));
  }
}
