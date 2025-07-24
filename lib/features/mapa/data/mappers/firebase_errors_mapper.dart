import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseErrorsMapper {
  static RepositoryFailures map(FirebaseException exception) {
    switch (exception.code) {
     // Firestore
      case 'firestore/permission-denied':
        return UnauthorizedFailure(originalException: exception);
      case 'firestore/deadline-exceeded':
        return TimeoutFailure(originalException: exception);
      case 'cloud-firestore/unavailable':
        return DatabaseFailure("Serviço indisponível", originalException: exception,);
      
     // Storage
      case 'firebase_storage/unauthorized':
        return UnauthorizedFailure(originalException: exception);
      case 'firebase_storage/canceled':
        return OperationCanceledFailure(originalException: exception);
      case 'firebase_storage/quota-exceeded':
        return LimitExceededFailure(originalException: exception);
      case 'firebase_storage/object-not-found':
        return PicoNotFoundFailure(originalException: exception);
      
      // Auth
      case 'firebase_auth/email-already-in-use':
        return EmailAlreadyInUseFailure(originalException: exception);
      case 'firebase_auth/invalid-email':
        return InvalidEmailFailure(originalException: exception);
      case 'firebase_auth/too-many-requests':
        return TooManyAttemptsFailure(originalException: exception);
      case 'firebase_auth/uid-already-exists':
        return AccountExistsFailure(originalException: exception);  
      case 'firebase_auth/user-token-expired':
        return ExpiredTokenFailure(originalException: exception);
      case 'firebase_auth/user-not-found':
        return UserNotFoundFailure(originalException: exception);
      
      // Genéricos
      default:
        return UnknownFailure(originalException: exception);
    }
  }
}