import 'package:demopico/core/common/errors/failure_server.dart';

abstract class RepositoryFailures extends Failure {
  RepositoryFailures({required super.message, super.code, super.originalException, super.stackTrace});
}

class NetworkFailure extends RepositoryFailures {
  NetworkFailure({super.originalException}): super(message: "Erro de conexão", code: 'NETWORK_FAILURE');
}

class TimeoutFailure extends RepositoryFailures {
  TimeoutFailure({super.originalException}): super(message: "Tempo limite excedido",code: 'TIMEOUT_FAILURE');
}

class UnknownError extends RepositoryFailures {
  UnknownError( {required super.message, super.stackTrace}): super(code: 'UNKNOWN_ERROR');
}


class CacheFailure extends RepositoryFailures {
  CacheFailure( {required super.message, super.originalException}): super(code: 'CACHE_FAILURE');
}

class DatabaseFailure extends RepositoryFailures {
  DatabaseFailure(String s, {super.originalException}): super(message:"", code: 'DATABASE_FAILURE');
}

class UnavailableFailure extends RepositoryFailures {
  UnavailableFailure({super.originalException}): super(message: "Serviço indisponível",code: 'UNAVAILABLE');
}


class ExpiredTokenFailure extends RepositoryFailures {
  ExpiredTokenFailure({super.originalException}): super(message: "Token expirado, refaça login",code: 'EXPIRED_TOKEN');
}

class AccountExistsFailure extends RepositoryFailures {
  AccountExistsFailure({super.originalException}): super(message: "Conta já existe",code: 'ACCOUNT_EXISTS');
}

class DataNotFoundFailure extends RepositoryFailures {
  final String? dataID;
  DataNotFoundFailure({super.originalException, this.dataID}): super(message: "Dados do id: ${dataID ?? ''} não encontrados",code: 'DATA_NOT_FOUND');
}

// Pico
class PicoNotFoundFailure extends RepositoryFailures {
  PicoNotFoundFailure({super.originalException}): super(message: "Pico não encontrado",code: 'PICO_NOT_FOUND');
}

// Usuário
class UserNotFoundFailure extends RepositoryFailures {
  UserNotFoundFailure({super.originalException}): super(message: "Usuário não encontrado", code: 'USER_NOT_FOUND');
}

// Arquivos 
class UploadFileFailure extends RepositoryFailures {
  UploadFileFailure({super.originalException}): super(message: "Erro ao fazer upload do arquivo", code: 'UPLOAD_FILE_FAILURE');
}

class FileNotFoundFailure extends RepositoryFailures {
  FileNotFoundFailure({super.originalException}): super(message: "Arquivo não encontrado", code: 'FILE_NOT_FOUND');
}

class LimitExceededFailure extends RepositoryFailures {
  LimitExceededFailure({super.originalException}): super(message: "Limite de arquivos excedido", code: 'LIMIT_EXCEEDED');
}

class OperationCanceledFailure extends RepositoryFailures {
  OperationCanceledFailure({super.originalException}): super(message: "Operação cancelada", code: 'OPERATION_CANCELED');
}

// Erro desconhecido
class UnknownFailure extends RepositoryFailures {
  final Object? unknownError;
  UnknownFailure({super.originalException, super.stackTrace, this.unknownError}): super(message: "Erro desconhecido: ${unknownError.toString()} - StackTrace: $stackTrace", code: 'UNKNOWN');
}

// Internal server error 
class InternalServerErrorFailure extends RepositoryFailures {
  InternalServerErrorFailure({super.originalException}): super(message: "Erro interno do servidor", code: 'INTERNAL_SERVER_ERROR');
}

class UploadFailure extends RepositoryFailures {
  UploadFailure({super.originalException}): super(message: "Ocorreu um erro ao fazer o upload", code: 'INTERNAL_SERVER_ERROR');
}

class EmailAlreadyInUseFailure extends RepositoryFailures {
  EmailAlreadyInUseFailure({super.originalException}): super(message: "Email já está em uso", code: 'EMAIL_ALREADY_IN_USE');  
}

class InvalidEmailFailure extends RepositoryFailures {
  InvalidEmailFailure({super.originalException}): super(message: "Formato de e-mail inválido", code: 'INVALID_EMAIL');
}

class TooManyAttemptsFailure extends RepositoryFailures {
  TooManyAttemptsFailure({super.originalException}): super(message: "Limite de tentativas excedido", code: 'TOO_MANY_ATTEMPTS');
} 

class DuplicateDataFailure extends RepositoryFailures {
  DuplicateDataFailure({required super.message}): super(code: "DUPLICATE_DATA_FAILURE");
}

class ProfileNotFoundFailure extends RepositoryFailures {
  ProfileNotFoundFailure({required super.originalException}) : super(message: "Perfil não encontrado");
}






  
