import 'package:demopico/features/user/domain/entity/user_credentials.dart';
import 'package:demopico/features/user/domain/usecases/criar_conta_uc.dart';
import 'package:demopico/features/user/domain/usecases/login_email_uc.dart';
import 'package:demopico/features/user/domain/usecases/login_vulgo_uc.dart';
import 'package:demopico/features/user/domain/usecases/logout_uc.dart';
import 'package:demopico/features/user/domain/usecases/pegar_id_usuario.dart';
import 'package:flutter/material.dart';

class AuthUserProvider  extends ChangeNotifier {
  static AuthUserProvider? _authUserProvider;

  static AuthUserProvider get getInstance {
    _authUserProvider ??= AuthUserProvider(
        criarContaUc: CriarContaUc.getInstance,
        loginEmailUc: LoginEmailUc.getInstance,
        loginVulgoUc: LoginVulgoUc.getInstance,
        logoutUc: LogoutUc.getInstance,
        pegarIdUsuario:  PegarIdUsuario.getInstance);
    return _authUserProvider!;
  }

  AuthUserProvider( 
      {required this.pegarIdUsuario,
      required this.criarContaUc,
      required this.loginEmailUc,
      required this.loginVulgoUc,
      required this.logoutUc});

  final CriarContaUc criarContaUc;
  final LoginEmailUc loginEmailUc;
  final LoginVulgoUc loginVulgoUc;
  final LogoutUc logoutUc;
  final PegarIdUsuario pegarIdUsuario;

  Future<bool> loginEmail(UserCredentialsSignIn credentials) async {
    try {
      return await loginEmailUc.logar(credentials);
    } catch (e) {
      return false;
    }
  }

  Future<bool> loginVulgo(UserCredentialsSignInVulgo credentials) async {
    try {
      return await loginVulgoUc.logar(credentials);
    } catch (e) {
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      await logoutUc.deslogar();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signUp(UserCredentialsSignUp credentials) async {
    return await criarContaUc.criar(credentials);
  }

  String? pegarId(){
    try{
      return pegarIdUsuario.pegar();
    }catch(e){
      return null;
    }
    
  }
}
