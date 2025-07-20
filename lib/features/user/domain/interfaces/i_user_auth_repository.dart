import 'package:demopico/features/user/domain/entity/user_credentials.dart';
import 'package:demopico/features/user/domain/models/user.dart';

abstract class IUserAuthRepository {
  Future<UserM> signUp(UserCredentialsSignUp cadastroCredentials);
  Future<UserM> login(UserCredentialsSignIn loginCredentials);
  Future<void> logout();
}
