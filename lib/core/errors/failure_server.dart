// Classe base para representar falhas
import 'package:flutter/material.dart';

abstract class Failure {
  final String message;

  Failure({this.message = 'An error occurred'});

  @override
  String toString() => message;
}

class SnackBarFailure extends SnackBar {
  final String message;
  const SnackBarFailure(
      {super.key, required this.message, required super.content});

  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 5),
      shape: const RoundedRectangleBorder(),
      elevation: 5,
    );
  }
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
