import 'package:demopico/features/user/domain/aplication/validate_credentials.dart';
import 'package:demopico/features/user/domain/entity/user_credentials.dart';
import 'package:demopico/features/user/domain/enums/identifiers.dart';
import 'package:demopico/features/user/domain/enums/sign_methods.dart';
import 'package:demopico/features/user/domain/usecases/criar_conta_uc.dart';
import 'package:demopico/features/user/domain/usecases/login_uc.dart';
import 'package:demopico/features/user/domain/usecases/logout_uc.dart';
import 'package:demopico/features/user/domain/usecases/pegar_id_usuario.dart';
import 'package:flutter/material.dart';

class AuthUserProvider  extends ChangeNotifier {
  static AuthUserProvider? _authUserProvider;

  static AuthUserProvider get getInstance {
    _authUserProvider ??= AuthUserProvider(
        criarContaUc: CriarContaUc.getInstance,
        loginEmailUc: LoginUc.getInstance,
        validateUserCredentials: ValidateUserCredentials.instance,
        logoutUc: LogoutUc.getInstance,
        pegarIdUsuario:  PegarIdUsuario.getInstance);
    return _authUserProvider!;
  }

  AuthUserProvider( 
      {required this.pegarIdUsuario,
      required ValidateUserCredentials validateUserCredentials,
      required this.criarContaUc,
      required this.loginEmailUc,
      required this.logoutUc}): _validateUserCredentials = validateUserCredentials;

  final CriarContaUc criarContaUc;
  final LoginUc loginEmailUc;
  final LogoutUc logoutUc;
  final PegarIdUsuario pegarIdUsuario;
  final ValidateUserCredentials _validateUserCredentials;

  bool isColetivo = false;
  bool isEmail = true;
  Identifiers identifier = Identifiers.email;
  

  void changeIsEmail(){
    isEmail = !isEmail;
    identifier = isEmail ? Identifiers.email : Identifiers.vulgo;
    notifyListeners();
  }

  void changeIsColetivo(){
    isColetivo = !isColetivo;
    notifyListeners();
  }

  Future<void> login() async {
    UserCredentialsSignIn credentials = UserCredentialsSignIn(
    signMethod: SignMethods.email, 
    identifier: identifier, 
    login: "", 
    senha: "");
    
    try {
      final validatedCredentials = await _validateUserCredentials.validateForLogin(credentials);
      await loginEmailUc.logar(validatedCredentials);  
    } catch (e) {

    }
  }



  Future<void> logout() async {
    try {
      await logoutUc.deslogar();
      
    } catch (e) {
      
    }
  }

  Future<void> signUp(UserCredentialsSignUp credentials) async {
     await criarContaUc.criar(credentials);
  }

  String? pegarId(){
    try{
      return pegarIdUsuario.pegar();
    }catch(e){
      return null;
    }
    
  }
}
