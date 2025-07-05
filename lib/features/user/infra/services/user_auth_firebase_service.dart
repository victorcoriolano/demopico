import 'package:demopico/features/user/domain/interfaces/i_user_auth_service.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/user_firebase_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserAuthFirebaseService implements IUserAuthService {
  static UserAuthFirebaseService? _userAuthFirebaseService;

  static UserAuthFirebaseService get getInstance {
    _userAuthFirebaseService ??= UserAuthFirebaseService(
        auth: FirebaseAuth.instance,
        userDatabaseRepositoryIMP: UserFirebaseRepository.getInstance);
    return _userAuthFirebaseService!;
  }

  UserAuthFirebaseService(
      {required this.auth, required this.userDatabaseRepositoryIMP});

  final FirebaseAuth auth;
  final IUserDatabaseRepository userDatabaseRepositoryIMP;

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;
  set setAuthenticated(bool value) => _isAuthenticated = value;

  Stream<User?> getAuthStateChanges() {
    return auth.authStateChanges();
  }

  @override
  Future<bool> signUp(String inputName, String inputEmail, String password,
      bool isColetivo) async {
    try {
      UserCredential authResult = await auth.createUserWithEmailAndPassword(
          email: inputEmail, password: password);
      User? signedInUser = authResult.user;

      if (signedInUser == null) throw Exception("O usuario não pode ser criado");

      UserM localUser = UserM.userFromFirebaseAuthUser(signedInUser, inputName, isColetivo);
      
      // Adiciona o usuário ao banco de dados
      await userDatabaseRepositoryIMP.addUserDetails(localUser);
      return true;
    } on FirebaseAuthException {
      throw Exception("Erro no sistema de autenticação");
    } catch (e) {
      throw Exception("Erro ao criar usuario");
    }
  }

  @override
  Future<bool> loginByEmail(String email, String password) async {
    try {
      final authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? signedUser = authResult.user;
      if (signedUser == null) throw Exception("Não foi possível fazer o login, usuario não encontrado");
      return true;
    } on FirebaseAuthException {
      throw Exception("Erro no sistema de autenticação");
    } catch (e) {
      throw Exception("Erro ao tentar realizar o login, tente novamente");
    }
  }

  @override
  Future<void> logout() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException {
      throw Exception("Erro no sistema de autenticação");
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception("Não foi possível deslogar, erro desconhecido");
    }
  }

  @override
  String currentUser() {
    String? idUser;
    if (auth.currentUser?.uid == null) {
      throw Exception("Erro ao pegar o currentUser");
    }
    idUser = auth.currentUser?.uid;
    return idUser!;
  }
}
