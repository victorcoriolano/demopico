

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
