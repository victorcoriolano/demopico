import 'dart:async';

import 'package:demopico/core/common/auth/domain/usecases/sign_up_uc.dart';
import 'package:demopico/core/common/auth/domain/value_objects/email_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/password_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/vulgo_vo.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/user/domain/aplication/validate_credentials.dart';
import 'package:demopico/core/common/auth/domain/entities/user_credentials.dart';
import 'package:demopico/features/user/presentation/controllers/profile_view_model.dart';
import 'package:flutter/material.dart';

class AuthViewModelSignUp extends ChangeNotifier {
  static AuthViewModelSignUp? _authUserProvider;

  static AuthViewModelSignUp get getInstance {
    _authUserProvider ??= AuthViewModelSignUp(
        profileViewModel: ProfileViewModel.getInstance,
        validateUserCredentials: ValidateUserCredentials.instance,
        signUp: SignUpUc.instance,);
    return _authUserProvider!;
  }

  AuthViewModelSignUp(
      {
      required ValidateUserCredentials validateUserCredentials,
      required ProfileViewModel profileViewModel,
      required SignUpUc signUp,
   })
      : _validateUserCredentials = validateUserCredentials,
        _signUpUc = signUp;

  final SignUpUc _signUpUc;
  final ValidateUserCredentials _validateUserCredentials;
  
  EmailVO emailField = EmailVO.empty();
  VulgoVo vulgoField = VulgoVo.empty();
  PasswordVo passwordField = PasswordVo("");

  String? errorEmail;
  String? errorVulgo;
  String? errorPassword;

  bool isLoading = false;

  void updateFieldEmail(String email){
    try{
      emailField = EmailVO(email);
    } on Failure catch (e) {
      errorEmail = e.message;
    }
  }

  void updateFieldVulgo(String vulgo){
    try{
      vulgoField = VulgoVo(vulgo);
    } on Failure catch (e) {
      errorVulgo = e.message;
    }
  }

  void updateFieldPassword(String newValue){
    try{
      passwordField = PasswordVo(newValue);
    }on Failure catch (e){
      errorPassword = e.message;
    }
  }

  Future<void> signUp(NormalUserCredentialsSignUp credentials) async {
    //limpando mensagens de erro a cada tentativa para
    // evitar que o erro persista após a alteração
    clearMessageErrors();
    isLoading = true;
    notifyListeners();

      final validCredentials =
          await _validateUserCredentials.validateForSignUp(credentials);
      final newUser = await _signUpUc.execute(validCredentials);

      newUser.failure != null 
        ? FailureServer.showError(newUser.failure!)
        : 

      isLoading = false;
      notifyListeners();

    }

    
  void clearMessageErrors() {
    errorEmail = null;
    errorPassword = null;
    errorVulgo = null;
  }
}
