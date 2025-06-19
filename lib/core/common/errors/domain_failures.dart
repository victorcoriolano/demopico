import 'package:demopico/core/common/errors/failure_server.dart';

abstract class DomainFailure extends Failure {
  DomainFailure(super.message,{
    super.code,
  });
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


class InvalidVulgoFailure extends DomainFailure {
  InvalidVulgoFailure(): super("Vulgo Inválido", code: 'invalid_vulgo');
}

class InvalidFormatFileFailure extends DomainFailure {
  InvalidFormatFileFailure(): super("Formato de arquivo inválido", code: 'invalid_file');
}

class InvalidSizeFileFailure extends DomainFailure {
  InvalidSizeFileFailure(): super("Tamanho de arquivo inválido", code: 'invalid_size_file');
}

class NoSuchFileFailure extends DomainFailure {
  NoSuchFileFailure(): super("Arquivo não encontrado", code: 'no_such_file');
}

class NoFileSelectedFailure extends DomainFailure {
  NoFileSelectedFailure(): super("Nenhum arquivo selecionado", code: 'no_file_selected');
}

class FileLimitExceededFailure extends DomainFailure {
  FileLimitExceededFailure(): super("Limite de arquivos excedido", code: 'file_limit_exceeded');
}
