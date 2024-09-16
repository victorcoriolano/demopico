import 'package:dartz/dartz.dart';
import 'package:demopico/core/errors/failure_server.dart';
import 'package:demopico/features/user/data/services/firebase_service.dart';
import 'package:demopico/features/user/domain/entities/user.dart';
import 'package:demopico/features/user/domain/interfaces/auth_interface.dart';

class AuthService implements AuthInterface {
  final FirebaseService firebaseService;
  AuthService(this.firebaseService);

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final userModel = await firebaseService.login(email, password);
      return right(userModel);
    } catch (e) {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> register(String email, String password) async {
    try {
      final userModel =
          await firebaseService.registerByEmailAndPassword(email, password);
      return Right(userModel);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> registerFirestore(
      String email, String vulgo) async {
    try {
      final userModel = await firebaseService.registerFirestore(email, vulgo);
      return Right(userModel);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String?>> getEmailByID(String id) async {
    try {
      final email = await firebaseService.getEmailByID(id);
      return Right(email);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String?>> getIdByVulgo(String vulgo) async {
    try {
      final id = await firebaseService.getIDByVulgo(vulgo);
      return Right(id);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
