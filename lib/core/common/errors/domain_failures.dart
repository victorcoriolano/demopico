import 'package:demopico/core/common/errors/failure_server.dart';

abstract class DomainFailure extends Failure {
  DomainFailure({
    required super.message,
    super.code,
  });
}

class InvalidUserFailure extends DomainFailure {
  InvalidUserFailure(): super(message: "Usuário inválido", code: 'invalid_user');
}

class EmailAlreadyExistsFailure extends DomainFailure {
  EmailAlreadyExistsFailure(): super(message: "Email de usuário já está em uso em outra conta", code: 'email_already_exists');
}

class VulgoAlreadyExistsFailure extends DomainFailure {
  VulgoAlreadyExistsFailure(): super(message: "Vulgo já está em uso", code: 'vulgo_already_exists');
}

class InvalidPasswordFailure extends DomainFailure {
  InvalidPasswordFailure(): super(message: "Senha inválida", code: 'invalid_password');
}


class InvalidVulgoFailure extends DomainFailure {
  InvalidVulgoFailure(): super(message: "Vulgo Inválido", code: 'invalid_vulgo');
}

class InvalidCredentialsFailure extends DomainFailure {
  final String? personalizedMessage;
  InvalidCredentialsFailure([this.personalizedMessage]): super(message: personalizedMessage ?? "Credenciais inválidas", code: "invalid_credentials");
}

class InvalidFormatFileFailure extends DomainFailure {
  InvalidFormatFileFailure(): super(message: "Formato de arquivo inválido", code: 'invalid_file');
}

class InvalidSizeFileFailure extends DomainFailure {
  InvalidSizeFileFailure(): super(message: "Tamanho de arquivo inválido", code: 'invalid_size_file');
}

class NoSuchFileFailure extends DomainFailure {
  NoSuchFileFailure(): super(message: "Arquivo não encontrado", code: 'no_such_file');
}

class NoFileSelectedFailure extends DomainFailure {
  NoFileSelectedFailure(): super(message: "Nenhum arquivo selecionado", code: 'no_file_selected');
}

class FileLimitExceededFailure extends DomainFailure {
  final String? messagemAdicional;
  FileLimitExceededFailure({this.messagemAdicional}): super(message: "Limite de arquivos excedido - ${messagemAdicional ?? ""}", code: 'file_limit_exceeded');
}

