

import 'package:barna_chat/feature_auth/domain/entities/user.dart';
import 'package:barna_chat/feature_auth/util/failure_server.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository{
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register(String email, String password);
  Future<Either<Failure, User>> registerFirestore(String email, String vulgo);
  Future<Either<Failure, String?>> getIdByVulgo(String vulgo);
  Future<Either<Failure, String?>> getEmailByID(String id);
}