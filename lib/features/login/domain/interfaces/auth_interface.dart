import 'package:dartz/dartz.dart';
import 'package:demopico/core/errors/failure_server.dart';
import 'package:demopico/features/login/domain/entities/user.dart';

abstract class AuthInterface {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register(String email, String password);
  Future<Either<Failure, User>> registerFirestore(String email, String vulgo);
  Future<Either<Failure, String?>> getIdByVulgo(String vulgo);
  Future<Either<Failure, String?>> getEmailByID(String id);
}
