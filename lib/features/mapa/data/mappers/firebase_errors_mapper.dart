import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseErrorsMapper {
  static Failure map(FirebaseException exception) {
    switch (exception.code) {
     // Firestore
      case 'permission-denied':
        return UnauthorizedFailure();
      case 'deadline-exceeded':
        return TimeoutFailure(originalException: exception);
      case 'unavailable':
        return DatabaseFailure("Serviço indisponível", originalException: exception,);
      
     // Storage
      case 'unauthorized':
        return UnauthorizedFailure();
      case 'canceled':
        return OperationCanceledFailure(originalException: exception);
      case 'quota-exceeded':
        return LimitExceededFailure(originalException: exception);
      case 'object-not-found':
        return DataNotFoundFailure(originalException: exception);
      
      // Auth
      case 'email-already-in-use':
        return EmailAlreadyInUseFailure(originalException: exception);
      case 'invalid-email':
        debugPrint("Email inválido detectado no mapeador dos erros do firebase");
        return InvalidEmailFailure(originalException: exception);
      case 'too-many-requests':
        return TooManyAttemptsFailure(originalException: exception);
      case 'uid-already-exists':
        return AccountExistsFailure(originalException: exception);  
      case 'user-token-expired':
        return ExpiredTokenFailure(originalException: exception);
      case 'user-not-found':
        return UserNotFoundFailure(originalException: exception);
      
      // Genéricos
      default:
        return UnknownFailure(originalException: exception);
    }
  }
}