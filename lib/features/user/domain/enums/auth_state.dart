import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';

sealed class AuthState {}

class AuthAuthenticated extends AuthState {
  AuthAuthenticated({
    required this.user,
  });

  final UserEntity user;
}

class AuthUnauthenticated extends AuthState {}
