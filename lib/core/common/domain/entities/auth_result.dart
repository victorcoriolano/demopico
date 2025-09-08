import 'package:demopico/core/common/domain/entities/auth_tokens.dart';
import 'package:demopico/core/common/domain/entities/user_entity.dart';
import 'package:demopico/core/common/errors/domain_failures.dart';

class AuthResult {
  final bool success;
  final TypeUser? user;
  final AuthTokens? tokens;
  final DomainFailure? failure;

  AuthResult._({
    required this.success,
    this.user,
    this.tokens,
    this.failure,
  });

  factory AuthResult.success({required TypeUser user, AuthTokens? tokens}) =>
      AuthResult._(success: true, user: user, tokens: tokens);

  factory AuthResult.failure(DomainFailure failure) =>
      AuthResult._(success: false, failure: failure);
}
