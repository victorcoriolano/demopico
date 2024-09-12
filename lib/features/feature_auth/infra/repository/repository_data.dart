

import 'package:barna_chat/feature_auth/domain/entities/user.dart';
import 'package:barna_chat/feature_auth/domain/infra/repository_uc.dart';
import 'package:barna_chat/feature_auth/infra/datasources/auth_datasouce.dart';
import 'package:barna_chat/feature_auth/infra/datasources/get_vulgo_by_id.dart';
import 'package:dartz/dartz.dart';

import '../../util/failure_server.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource firebaseDataSource;
  final GetIdByVulgo getId;
  AuthRepositoryImpl(this.firebaseDataSource, this.getId);

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try{
      final userModel = await firebaseDataSource.login(email, password);
      return right(userModel);
    }catch (e){
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> register(String email, String password) async {
    try {
      final userModel = await firebaseDataSource.register(email, password);
      return Right(userModel);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> registerFirestore(String email, String vulgo) async{
    try{
      final userModel = await firebaseDataSource.registerFirestore(email, vulgo);
      return Right(userModel);
    }
    catch (e) {
      return Left(ServerFailure());
    }
  }
  @override
  Future<Either<Failure, String?>> getEmailByID(String id) async{
    try{
      final email = await getId.getEmailByID(id);
      return Right(email);
    }
    catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String?>> getIdByVulgo(String vulgo) async{
    try{
      final id = await getId.getIDByVulgo(vulgo);
      return Right(id);
    }
    catch (e) {
      return Left(ServerFailure());
    }
  }
}

