import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/errors/domain_failures.dart';

class AuthResult {
  final bool success;
  final TypeUser? user;
  final DomainFailure? failure;

  AuthResult._({
    required this.success,
    this.user,
    this.failure,
  });

  factory AuthResult.success({required TypeUser user}) =>
      AuthResult._(success: true, user: user);

  factory AuthResult.failure(DomainFailure failure) =>
      AuthResult._(success: false, failure: failure);
}
