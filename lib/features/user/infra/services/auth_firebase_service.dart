import 'package:demopico/features/user/domain/interfaces/i_user_auth_service.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/auth_enum.dart';
import 'package:demopico/features/user/infra/repositories/sign_methods.dart';
import 'package:demopico/features/user/infra/repositories/user_firebase_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthFirebaseService implements IUserAuthService{
  
  static AuthFirebaseService? _authFirebaseService;

 static AuthFirebaseService get getInstace{
    _authFirebaseService ??= AuthFirebaseService(auth: FirebaseAuth.instance, userDatabaseRepositoryIMP: UserFirebaseRepository.getInstance);
    return _authFirebaseService!;
  }

  AuthFirebaseService({required this.auth, required this.userDatabaseRepositoryIMP});

  final FirebaseAuth auth;
  final IUserDatabaseRepository userDatabaseRepositoryIMP;

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
            picosAdicionados: '0',
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


  Future<bool> signUp(String inputName, String inputEmail, String password, bool isColetivo) async {
    try {
      UserCredential authResult = await auth.createUserWithEmailAndPassword(
          email: inputEmail, password: password);
      User? signedInUser = authResult.user;
      UserM? localUser = userFromFirebaseUser(signedInUser);
      if(localUser == null) throw Exception("O usuario não pode ser nulo para salvar no banco");
      await userDatabaseRepositoryIMP.addUserDetails(localUser);


      //verifica se ele é válido, seta os estados de auth e cria o user no db
      if (signedInUser != null && signedInUser.uid.isNotEmpty) {
        signedInUser.updateDisplayName(inputName);
        //cria um user model de acordo com a nova conta criada
        UserM? localUser = userFromFirebaseUser(signedInUser);
        //atualização da model temporaria
        if (localUser != null) {
          localUser.isColetivo = isColetivo;

          localUser.signMethod = SignMethods.email;
          localUser.email = inputEmail;
          localUser.name = inputName;
          //atualização da model local e adiciona o user no repository
          _localUser = localUser;
          await dbService
              .addUserDetailsToFirestore(newUser: _localUser!);
             
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

  Future<bool> loginByEmail(String email, String password) async {
    try {
      final authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? signedUser = authResult.user;

      if (signedUser != null) {
        UserM? firestoreUser =
            await dbService.getUserDetailsFromFirestore(signedUser.uid);
        auth.currentUser!.updateDisplayName(firestoreUser!.name);
        auth.currentUser!.updatePhotoURL(firestoreUser.pictureUrl);
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
