import 'package:demopico/features/user/data/models/loggeduser.dart';
import 'package:demopico/features/user/data/models/user.dart';
import 'package:demopico/features/user/data/repositories/auth_enum.dart';
import 'package:demopico/features/user/data/repositories/sign_methods.dart';
import 'package:demopico/features/user/data/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static DatabaseService dbService = DatabaseService.instance;

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;
  set setAuthenticated(bool value) => _isAuthenticated = value;

  UserM? _localUser;
  UserM? get getLocalUser => _localUser;

  String todayDate =
      '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}';

  //transforma dados do firebase em dados na model
  //cria um user model de acordo com a nova conta criada
  UserM? userFromFirebaseUser(User? user) {
    return user != null
        ? UserM(
            description: 'Edite para atualizar sua bio',
            id: user.uid,
            picosAdicionados: '0',
            picosSalvos: '0',
            location: null,
            conexoes: '0',
            dob: todayDate,
            authEnumState: AuthEnumState.notDetermined,
            pictureUrl:
                'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/640px-User_icon_2.svg.png',
          )
        : null;
  }

  Stream<User?> getAuthStateChanges() {
    return auth.authStateChanges();
  }

  User? get currentUser {
    if (auth.currentUser == null) return null;
    return auth.currentUser;
  }

///////////////////////////////////
  /// SIGN UP
///////////////////////////////////
  ///
  Future<bool> signUp(String inputName, String inputEmail, String inputPassword,
      bool isColetivo) async {
    try {
      UserCredential authResult = await auth.createUserWithEmailAndPassword(
          email: inputEmail, password: inputPassword);

      User? signedInUser = authResult.user;

      //cria um user model de acordo com a nova conta criada
      UserM? localUser = userFromFirebaseUser(signedInUser);

      //verifica se ele é válido, seta os estados de auth e cria o user no db
      if (signedInUser != null && localUser!.id != null) {
        //atualização da model temporaria
        localUser.isColetivo = isColetivo;
        localUser.signMethod = SignMethods.email;
        localUser.email = inputEmail;
        localUser.name = inputName;
        //usando updateprofile pra ter acesso ao nome do user e etc
        await signedInUser.updateProfile(
            displayName: inputName, photoURL: localUser.pictureUrl);
        //atualização da model local e adiciona o user no repository
        _localUser = localUser;
        //setter da variavel de estado de autenticação
        _localUser!.authEnumState = AuthEnumState.loggedIn;
        setAuthenticated = true;
        //cria o user no db
        LoggedUserModel(user: _localUser!);
        await dbService.addUserDetailsToFirestore(newUser: _localUser!);
        return true;
      }
      return false;
    } catch (e) {
      _localUser!.authEnumState = AuthEnumState.notLoggedIn;
      return false;
    }
  }

////////////////////
  /// LOGIN
////////////////////

  Future<bool> login(String email, String password) async {
    try {
      UserCredential authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? signedUser = authResult.user;
      _localUser = userFromFirebaseUser(signedUser);
      _localUser!.authEnumState = AuthEnumState.loggedIn;
      setAuthenticated = true;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }}
  }
}
