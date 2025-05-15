import 'package:demopico/core/common/errors/failure_server.dart';

abstract class DomainFailure extends Failure {
  DomainFailure(super.message,{
    super.code,
  });
}

class UserNotFoundFailure extends DomainFailure {
  UserNotFoundFailure(): super("Usuário não encontrado", code: 'user_not_found');
}

class AttemptLimitExceededFailure extends DomainFailure {
  AttemptLimitExceededFailure(): super("Limite de tentativas excedido", code: 'attempt_limit_exceeded');
}

class InvalidCredentialsFailure extends DomainFailure {
  InvalidCredentialsFailure(): super("Credenciais inválidas", code: 'invalid_credentials');
}

class EmailAlreadyExistsFailure extends DomainFailure {
  EmailAlreadyExistsFailure(): super("Email de usuário já está em uso em outra conta", code: 'email_already_exists');
}

class VulgoAlreadyExistsFailure extends DomainFailure {
  VulgoAlreadyExistsFailure(): super("Vulgo já está em uso", code: 'vulgo_already_exists');
}

class InvalidPasswordFailure extends DomainFailure {
  InvalidPasswordFailure(): super("Senha inválida", code: 'invalid_password');
}

class InvalidEmailFailure extends DomainFailure {
  InvalidEmailFailure(): super("Email Inválido", code: 'invalid_email');
}