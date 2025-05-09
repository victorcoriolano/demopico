import 'package:demopico/features/user/domain/entity/user_credentials.dart';

abstract class IUserAuthRepository {
  Future<bool> signUp(UserCredentialsSignUp cadastroCredentials);
  Future<bool> loginByEmail(UserCredentialsSignIn loginCredentials);
  Future<bool> loginByVulgo(UserCredentialsSignInVulgo loginCredentials);
  Future<void> logout();
}
