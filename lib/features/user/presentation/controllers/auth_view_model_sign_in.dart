import 'dart:async';

import 'package:demopico/core/common/auth/domain/entities/auth_result.dart';
import 'package:demopico/core/common/auth/domain/usecases/sign_in_email_password_uc.dart';
import 'package:demopico/core/common/auth/domain/usecases/sign_in_vulgo_uc.dart';
import 'package:demopico/core/common/auth/domain/value_objects/email_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/password_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/vulgo_vo.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/user/domain/aplication/validate_credentials.dart';
import 'package:demopico/core/common/auth/domain/entities/user_credentials.dart';
import 'package:demopico/features/user/domain/enums/identifiers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthViewModelSignIn extends ChangeNotifier {
  static AuthViewModelSignIn? _authUserProvider;

  static AuthViewModelSignIn get getInstance {
    _authUserProvider ??= AuthViewModelSignIn(
        signInVulgo: SignInVulgoUc.instance,
        loginEmailUc: SignInEmailPasswordUc.instance,
        validateUserCredentials: ValidateUserCredentials.instance,);
    return _authUserProvider!;
  }

  AuthViewModelSignIn(
      {
      required ValidateUserCredentials validateUserCredentials,
      required SignInVulgoUc signInVulgo,
      required this.loginEmailUc,})
      : _validateUserCredentials = validateUserCredentials,
        _loginByVulgo = signInVulgo;

  final SignInEmailPasswordUc loginEmailUc;
  final SignInVulgoUc _loginByVulgo;
  final ValidateUserCredentials _validateUserCredentials;

  Identifiers identifier = Identifiers.email;
  bool isEmail = true;

  String getHintToFieldLogin() {
    switch (identifier){
      case Identifiers.email:
        return "Digite seu email";
      case Identifiers.vulgo:
        return "Digite seu vulgo";
    }
  }

  late EmailVO _email;
  late VulgoVo _vulgo;
  late PasswordVo _passwordVo;
  String login = "";
  String password = "";

  bool isLoading = false;


  void changeIsCredential(bool value) {
    identifier = Identifiers.fromIsEmail(value);
    notifyListeners();
  }

  bool validateCreationEmail(value){
    try {
      _email = EmailVO(value);
      return true;
    } on Failure catch (failure){
      FailureServer.showError(failure);
      return false;
    }
  }

  bool validateCreationVulgo(value){
    try {
      _vulgo = VulgoVo(value);
      return true;
    } on Failure catch (failure){
      FailureServer.showError(failure);
      return false;
    }
  }
  
  bool validateCreationPassword(value){
    try {
      _passwordVo = PasswordVo(value);
      return true;
    } on Failure catch (failure){
      FailureServer.showError(failure);
      return false;
    }
  }


  Future<void> signIn() async {
    isLoading = true;
    final AuthResult authResult;
    if(!validateCreationPassword(password)) return;

    switch (identifier){
      case Identifiers.email:
          debugPrint(login);
          if(!validateCreationEmail(login)) return;
          final credentials = EmailCredentialsSignIn(identifier: _email, senha: _passwordVo);
          final validatedCredentials =
            await _validateUserCredentials.validateEmailExist(credentials);
          authResult = await loginEmailUc.execute(validatedCredentials);
       
      case Identifiers.vulgo:
        if(!validateCreationVulgo(login)) return;
        final credentials = VulgoCredentialsSignIn(vulgo: _vulgo, password: PasswordVo(password));
        final validatedCredentials =
            await _validateUserCredentials.validateVulgoExist(credentials);
          authResult = await _loginByVulgo.execute(validatedCredentials);
    }

    if(authResult.success){
      debugPrint("Autenticação bem sucedida");

    }else {
      FailureServer.showError(authResult.failure!);
    }   
  }

  void getError(Failure e, [String? message]) {
    final messageError = message ?? "ERRO";
    Get.snackbar(messageError, e.message);
  }
}
