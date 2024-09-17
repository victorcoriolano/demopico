

// Classe base para representar falhas
abstract class Failure {
  final String message;

  Failure({this.message = 'An error occurred'});

  @override
  String toString() => message;
}

// Falha específica do servidor
class ServerFailure extends Failure {
  ServerFailure({super.message = 'Server failure'});
}

// Exemplo de outras possíveis falhas (pode expandir conforme necessário)
class NetworkFailure extends Failure {
  NetworkFailure({super.message = 'Network failure'});
}

class CacheFailure extends Failure {
  CacheFailure({super.message = 'Cache failure'});
}

class UserNotFoundFailure extends Failure {
  UserNotFoundFailure({super.message = 'Não achamos ninguém com esse vulgo!'});
}

class WrongPasswordFailure extends Failure {
  WrongPasswordFailure({super.message = 'Você digitou uma senha errada!'});
}

class InvalidEmailFailure extends Failure {
  InvalidEmailFailure({super.message = 'Esse e-mail é inválido. '});
}