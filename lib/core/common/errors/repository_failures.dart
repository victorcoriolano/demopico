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
  ExpiredTokenFailure({super.originalException}): super("Token expirado",code: 'EXPIRED_TOKEN');
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
class NoFileSelectedFailure extends RepositoryFailures {
  NoFileSelectedFailure({super.originalException}): super("Nenhum arquivo selecionado", code: 'NO_FILE_SELECTED');
}

class UploadFileFailure extends RepositoryFailures {
  UploadFileFailure({super.originalException}): super("Erro ao fazer upload do arquivo", code: 'UPLOAD_FILE_FAILURE');
}

class InvalidFileFailure extends RepositoryFailures {
  InvalidFileFailure({super.originalException}): super("Arquivo inválido", code: 'INVALID_FILE');
}

class InvalidFileSizeFailure extends RepositoryFailures {
  InvalidFileSizeFailure({super.originalException}): super("Tamanho do arquivo inválido", code: 'INVALID_FILE_SIZE');
}

class InvalidFileFormatFailure extends RepositoryFailures {
  InvalidFileFormatFailure({super.originalException}): super("Formato de arquivo inválido", code: 'INVALID_FILE_FORMAT');
}

class LimitExceededFailure extends RepositoryFailures {
  LimitExceededFailure({super.originalException}): super("Limite de arquivos excedido", code: 'LIMIT_EXCEEDED');
}

// Erro desconhecido
class UnknownFailure extends RepositoryFailures {
  UnknownFailure({super.originalException}): super("Erro desconhecido", code: 'UNKNOWN');
}

// Internal server error 
class InternalServerErrorFailure extends RepositoryFailures {
  InternalServerErrorFailure({super.originalException}): super("Erro interno do servidor", code: 'INTERNAL_SERVER_ERROR');
}





  
