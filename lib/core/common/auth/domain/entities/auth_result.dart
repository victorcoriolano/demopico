import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/errors/failure_server.dart';

class AuthResult {
  final bool success;
  final UserEntity? user;
  final Failure? failure;

  AuthResult._({
    required this.success,
    this.user,
    this.failure,
  });

  factory AuthResult.success({required UserEntity user}) =>
      AuthResult._(success: true, user: user);

  factory AuthResult.failure(Failure failure) =>
      AuthResult._(success: false, failure: failure);
}
