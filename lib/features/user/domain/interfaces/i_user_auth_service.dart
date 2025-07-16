
import 'package:demopico/features/user/domain/entity/user_credentials.dart';
import 'package:demopico/features/user/domain/models/user.dart';

abstract class IUserAuthService {
  Future<UserM> signUp(UserCredentialsSignUp authUser);
  
  Future<void> loginByEmail(UserCredentialsSignIn credentials);
  Future<void> logout();
  String get currentUser;
}