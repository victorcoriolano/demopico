import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseErrorsMapper {
  static RepositoryFailures map(FirebaseException exception) {
    switch (exception.code) {
      case 'unauthorized':
          return UnauthorizedFailure(originalException: exception);
        case 'cancelled':
          return UploadFileFailure(originalException: exception);
        case 'quota-exceeded':
          return LimitExceededFailure(originalException: exception);
        case 'network-request-failed':
          return NetworkFailure(originalException: exception);
        case 'unauthenticated':
          return UnauthenticatedFailure(originalException: exception);
        default:
          return UploadFileFailure(originalException: exception);
    }
  }
}