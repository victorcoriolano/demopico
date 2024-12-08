import 'package:demopico/features/user/data/models/user.dart';
import 'package:demopico/features/user/data/repositories/auth_enum.dart';
import 'package:demopico/features/user/data/repositories/sign_methods.dart';
import 'package:demopico/features/user/data/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
            name: user.displayName,
            email: user.email,
            description: 'Edite para atualizar sua bio',
            id: user.uid,
            picosAdicionados: 0,
            picosSalvos: '0',
            location: null,
            conexoes: '0',
            dob: todayDate,
            authEnumState: AuthEnumState.notDetermined,
            pictureUrl: null,
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
      print('pegando usercredential do authresult');
      User? signedInUser = authResult.user;
      print('pegando signedinuser do authresult.user');

      //verifica se ele é válido, seta os estados de auth e cria o user no db
      if (signedInUser != null && signedInUser.uid.isNotEmpty) {
        signedInUser.updateDisplayName(inputName);
        print('atualizando displayname');
        //cria um user model de acordo com a nova conta criada
        UserM? localUser = userFromFirebaseUser(signedInUser);
        //atualização da model temporaria
        if (localUser != null) {
          print('local user nao e null');
          localUser.isColetivo = isColetivo;
          localUser.signMethod = SignMethods.email;
          localUser.email = inputEmail;
          localUser.name = inputName;
          //atualização da model local e adiciona o user no repository
          _localUser = localUser;
          await dbService
              .addUserDetailsToFirestore(newUser: _localUser!)
              .whenComplete(
                  () => print('finalizado o adduserdetailstofirestore'));
          return true;
        } else {
          print('local user null');
        }
      } else {
        print('signedinuser null');
      }
      return false;
    } catch (e) {
      print('EXCEPTION NO TRY DO METODO SIGN UP');
      print(e);
      return false;
    }
  }

////////////////////
  /// LOGIN
////////////////////
///
///
///

  Future<bool> login(String email, String password) async {
    try {
      print("Tentou fazer login");
      final authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(authResult.additionalUserInfo);
      User? signedUser = authResult.user;
      print(signedUser?.metadata);
      if (signedUser != null) {
        print(signedUser.uid);
        UserM? firestoreUser =
            await dbService.getUserDetailsFromFirestore(signedUser.uid);
        auth.currentUser!.updateDisplayName(firestoreUser!.name);
        auth.currentUser!.updatePhotoURL(firestoreUser.pictureUrl);
        print(firestoreUser.toString());
        auth.userChanges();
        return true;
      }
      return false;
    } catch (e) {
      print(e.toString());
      print('erro no login authservice: $e');
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
