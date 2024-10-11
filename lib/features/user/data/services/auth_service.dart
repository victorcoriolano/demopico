import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:demopico/core/errors/failure_server.dart';
import 'package:demopico/features/user/data/models/user_credentials.dart';
import 'package:demopico/features/user/data/models/user_model.dart';
import 'package:demopico/features/user/data/repositories/user_repository.dart';
import 'package:demopico/features/user/data/services/firebase_service.dart';
import 'package:demopico/features/user/domain/entities/user.dart';
import 'package:demopico/features/user/domain/interfaces/auth_interface.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;

class AuthService implements AuthInterface {
  final FirebaseService firebaseService;
  final FirebaseFirestore firebaseFirestore;
  AuthService({required this.firebaseService, required this.firebaseFirestore});

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final userModel = await firebaseService.login(email, password);
      return right(userModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return left(UserNotFoundFailure());
      } else if (e.code == 'wrong-password') {
        return left(WrongPasswordFailure());
      } else if (e.code == 'invalid-email') {
        return left(InvalidEmailFailure());
      } else {
        return left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, User>> register(String email, String password) async {
    try {
      final userModel =
          await firebaseService.registerByEmailAndPassword(email, password);
      CredentialsRepository.usersCredentials
          .add(UserCredentials.fromFirebase(userModel));
      return right(userModel);
    } on FirebaseAuthException catch (e) {
      //por que que a senha estaria errada aqui ? sendo que é pra registrar kkkkk
      if (e.code == 'user-not-found') {
        return left(UserNotFoundFailure());
      } else if (e.code == 'wrong-password') {
        return left(WrongPasswordFailure());
      } else if (e.code == 'invalid-email') {
        return left(InvalidEmailFailure());
      } else {
        return left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, User>> registerFirestore(
      String email, String vulgo) async {
    try {
      final userModel = await firebaseService.registerFirestore(email, vulgo);
      return right(userModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return left(UserNotFoundFailure());
      } else if (e.code == 'wrong-password') {
        return left(WrongPasswordFailure());
      } else if (e.code == 'invalid-email') {
        return left(InvalidEmailFailure());
      } else {
        return left(ServerFailure());
      }
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
