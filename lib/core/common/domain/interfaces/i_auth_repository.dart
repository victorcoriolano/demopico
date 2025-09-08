import 'package:demopico/core/common/domain/entities/auth_result.dart';
import 'package:demopico/core/common/domain/entities/auth_tokens.dart';
import 'package:demopico/core/common/domain/entities/user_entity.dart';
import 'package:demopico/features/user/domain/enums/auth_state.dart';

abstract class IAuthRepository {
  Future<AuthResult> signInWithEmail(String email, String password);
  Future<AuthResult> signInWithGoogle(); // new provider
  Future<void> signOut();
  Future<AuthTokens?> refreshTokensIfNeeded(); // returns null if unauthenticated
  Stream<AuthState> get authState; // emits Authenticated(User) or Unauthenticated
  TypeUser? get currentUser; // in-memory domain user
}