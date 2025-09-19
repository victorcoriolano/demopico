import 'package:demopico/core/common/auth/domain/entities/auth_result.dart';
import 'package:demopico/core/common/auth/domain/entities/user_credentials.dart';

import 'package:demopico/features/user/domain/enums/auth_state.dart';

abstract class IAuthRepository {
  Future<AuthResult> signInWithEmail(EmailCredentialsSignIn credendials);
  Future<AuthResult> signInWithGoogle(GoogleCredentialsSignIn credentials); // new provider  
  Future<void> signOut();
  Future<AuthResult> signUp(NormalUserCredentialsSignUp credentials); 
  Stream<AuthState> get authState; // emits Authenticated(User) or Unauthenticated
  AuthState get currentAuthState;
}