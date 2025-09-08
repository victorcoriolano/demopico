import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/mapa/data/mappers/firebase_errors_mapper.dart';
import 'package:demopico/core/common/auth/domain/entities/user_credentials.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_auth_service.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService implements IUserAuthService {
  static FirebaseAuthService? _userAuthFirebaseService;

  static FirebaseAuthService get getInstance {
    _userAuthFirebaseService ??= FirebaseAuthService(
        auth: FirebaseAuth.instance,
        userDatabaseRepositoryIMP: UserDataRepositoryImpl.getInstance);
    return _userAuthFirebaseService!;
  }

  FirebaseAuthService(
      {required this.auth, required this.userDatabaseRepositoryIMP});

  final FirebaseAuth auth;
  final IUserDataRepository userDatabaseRepositoryIMP;

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;
  set setAuthenticated(bool value) => _isAuthenticated = value;
  

  Stream<User?> getAuthStateChanges() {
    return auth.authStateChanges();
  }

  @override
  Future<UserM> signUp(UserCredentialsSignUp authUser) async {
    try {
      UserCredential authResult = await auth.createUserWithEmailAndPassword(
          email: authUser.email, password: authUser.password);
      User? signedInUser = authResult.user;

      if (signedInUser == null) throw InvalidUserFailure();
      
      authUser.id=signedInUser.uid;

      final UserM localUser = UserM.initial(authUser);
      
      return localUser;
    } on FirebaseAuthException catch (firebaseAuthExceptio) {
      throw FirebaseErrorsMapper.map(firebaseAuthExceptio);
    } on Failure catch (e){
      debugPrint("DATASOURCE: falha conhecida - $e. Relançando...");
      rethrow;
    }on Exception catch (e, st) {
      throw UnknownFailure(originalException: e, stackTrace: st);
    } 
  }

  @override
  Future<String> loginByEmail(UserCredentialsSignIn credentials) async {
    try {
      final authResult = await auth.signInWithEmailAndPassword(
          email: credentials.login, password: credentials.senha);
      User? signedUser = authResult.user;
      if (signedUser == null) throw InvalidUserFailure();
      return signedUser.uid;
    } on FirebaseAuthException catch (firebaseAuthException) {
      throw FirebaseErrorsMapper.map(firebaseAuthException);
    } on Exception catch (e, st) {
      throw UnknownFailure(originalException: e, stackTrace: st);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (firebaseAuthException) {
      throw FirebaseErrorsMapper.map(firebaseAuthException);
    } on Exception catch (e, st) {
      throw UnknownFailure(originalException: e, stackTrace: st);
    }
  }

  @override
  String? get currentIdUser {
    try {
      return auth.currentUser?.uid;
    } on FirebaseAuthException catch (firebaseAuthException) {
      throw FirebaseErrorsMapper.map(firebaseAuthException);
    } on Exception catch (e, st) {
      throw UnknownFailure(originalException: e, stackTrace: st);
    }
  }
  

}
