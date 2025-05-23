import 'package:demopico/core/common/errors/failure_server.dart';

abstract class RepositoryFailures extends Failure {
  RepositoryFailures(super.message, {super.code, super.originalException, super.stackTrace});
}

class NetworkFailure extends RepositoryFailures {
  NetworkFailure({super.originalException}): super("Erro de conexão", code: 'NETWORK_FAILURE');
}

class TimeoutFailure extends RepositoryFailures {
  TimeoutFailure({super.originalException}): super("Tempo limite excedido",code: 'TIMEOUT_FAILURE');
}


class CacheFailure extends RepositoryFailures {
  CacheFailure(super.message, {super.originalException}): super(code: 'CACHE_FAILURE');
}

class DatabaseFailure extends RepositoryFailures {
  DatabaseFailure(super.message, {super.originalException}): super(code: 'DATABASE_FAILURE');
}

class UnavailableFailure extends RepositoryFailures {
  UnavailableFailure({super.originalException}): super("Serviço indisponível",code: 'UNAVAILABLE');
}

class UnauthorizedFailure extends RepositoryFailures {
  UnauthorizedFailure({super.originalException}): super("Usuário não autorizado",code: 'UNAUTHORIZED');
}

class UnauthenticatedFailure extends RepositoryFailures {
  UnauthenticatedFailure({super.originalException}): super("Usuário não autenticado",code: 'UNAUTHENTICATED');
}

class ExpiredTokenFailure extends RepositoryFailures {
  ExpiredTokenFailure({super.originalException}): super("Token expirado, refaça login",code: 'EXPIRED_TOKEN');
}

class AccountExistsFailure extends RepositoryFailures {
  AccountExistsFailure({super.originalException}): super("Conta já existe",code: 'ACCOUNT_EXISTS');
}

class DataNotFoundFailure extends RepositoryFailures {
  DataNotFoundFailure({super.originalException}): super("Dados não encontrados",code: 'DATA_NOT_FOUND');
}

// Pico
class PicoNotFoundFailure extends RepositoryFailures {
  PicoNotFoundFailure({super.originalException}): super("Pico não encontrado",code: 'PICO_NOT_FOUND');
}

// Usuário
class UserNotFoundFailure extends RepositoryFailures {
  UserNotFoundFailure({super.originalException}): super("Usuário não encontrado", code: 'USER_NOT_FOUND');
}

// Arquivos 


class UploadFileFailure extends RepositoryFailures {
  UploadFileFailure({super.originalException}): super("Erro ao fazer upload do arquivo", code: 'UPLOAD_FILE_FAILURE');
}

class FileNotFoundFailure extends RepositoryFailures {
  FileNotFoundFailure({super.originalException}): super("Arquivo não encontrado", code: 'FILE_NOT_FOUND');
}

class LimitExceededFailure extends RepositoryFailures {
  LimitExceededFailure({super.originalException}): super("Limite de arquivos excedido", code: 'LIMIT_EXCEEDED');
}

class OperationCanceledFailure extends RepositoryFailures {
  OperationCanceledFailure({super.originalException}): super("Operação cancelada", code: 'OPERATION_CANCELED');
}

// Erro desconhecido
class UnknownFailure extends RepositoryFailures {
  UnknownFailure({super.originalException, super.stackTrace}): super("Erro desconhecido", code: 'UNKNOWN');
}

// Internal server error 
class InternalServerErrorFailure extends RepositoryFailures {
  InternalServerErrorFailure({super.originalException}): super("Erro interno do servidor", code: 'INTERNAL_SERVER_ERROR');
}

class EmailAlreadyInUseFailure extends RepositoryFailures {
  EmailAlreadyInUseFailure({super.originalException}): super("Email já está em uso", code: 'EMAIL_ALREADY_IN_USE');  
}

class InvalidEmailFailure extends RepositoryFailures {
  InvalidEmailFailure({super.originalException}): super("Formato de e-mail inválido", code: 'INVALID_EMAIL');
}

class TooManyAttemptsFailure extends RepositoryFailures {
  TooManyAttemptsFailure({super.originalException}): super("Limite de tentativas excedido", code: 'TOO_MANY_ATTEMPTS');
} 





  
