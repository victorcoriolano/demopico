import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/mapa/data/mappers/firebase_errors_mapper.dart';
import 'package:demopico/features/user/domain/entity/user_credentials.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_auth_service.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuthFirebaseService implements IUserAuthService {
  static UserAuthFirebaseService? _userAuthFirebaseService;

  static UserAuthFirebaseService get getInstance {
    _userAuthFirebaseService ??= UserAuthFirebaseService(
        auth: FirebaseAuth.instance,
        userDatabaseRepositoryIMP: UserDataRepositoryImpl.getInstance);
    return _userAuthFirebaseService!;
  }

  UserAuthFirebaseService(
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

      final UserM localUser = UserM.initial(authUser);
      
      return localUser;
    } on FirebaseAuthException {
      throw Exception("Erro no sistema de autenticação");
    } catch (e) {
      throw Exception("Erro ao criar usuario");
    }
  }

  @override
  Future<String> loginByEmail(UserCredentialsSignIn credentials) async {
    try {
      final authResult = await auth.signInWithEmailAndPassword(
          email: credentials.login, password: credentials.senha);
      User? signedUser = authResult.user;
      if (signedUser == null) throw Exception("Não foi possível fazer o login, usuario não encontrado");
      return signedUser.uid;
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
    } on FirebaseAuthException catch (e){
      throw FirebaseErrorsMapper.map(e);
    } catch (e, st) {
      throw UnknownFailure(unknownError: e, stackTrace: st);
    }
  }

  @override
  String get currentUser {
    String? idUser;
    if (auth.currentUser?.uid == null) {
      throw InvalidUserFailure();
    }
    idUser = auth.currentUser?.uid;
    return idUser!;
  }
}
