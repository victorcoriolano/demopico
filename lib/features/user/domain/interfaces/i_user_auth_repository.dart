import 'package:demopico/core/common/auth/domain/entities/user_credentials.dart';
import 'package:demopico/features/user/domain/models/user.dart';

abstract class IUserAuthRepository {
  Future<UserM> signUp(UserCredentialsSignUp cadastroCredentials);
  Future<String> login(UserCredentialsSignIn loginCredentials);
  Future<void> logout();
}
