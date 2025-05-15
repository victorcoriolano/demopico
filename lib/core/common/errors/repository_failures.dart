import 'package:demopico/core/common/errors/failure_server.dart';

abstract class RepositoryFailures extends Failure {
  RepositoryFailures(super.message, {super.code, super.originalException});
}

class NetworkFailure extends RepositoryFailures {
  NetworkFailure(super.message, {super.originalException}): super(code: 'NETWORK_FAILURE');
}

class PermissionDatabaseFailure extends RepositoryFailures {
  PermissionDatabaseFailure(super.message, {super.originalException}): super(code: 'PERMISSION_DATABASE_FAILURE');
}

class CacheFailure extends RepositoryFailures {
  CacheFailure(super.message, {super.originalException}): super(code: 'cache_failure');
}
  
