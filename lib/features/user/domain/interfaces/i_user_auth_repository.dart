import 'package:demopico/features/user/domain/entity/user_credentials.dart';
import 'package:demopico/features/user/domain/models/user.dart';

abstract class IUserAuthRepository {
  Future<UserM> signUp(UserCredentialsSignUp cadastroCredentials);
  Future<void> loginByEmail(UserCredentialsSignIn loginCredentials);
  Future<void> loginByVulgo(UserCredentialsSignInVulgo loginCredentials);
  Future<void> logout();
}
