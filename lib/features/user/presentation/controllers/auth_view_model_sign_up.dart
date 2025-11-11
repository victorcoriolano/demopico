import 'dart:async';

import 'package:demopico/core/common/auth/domain/usecases/sign_up_uc.dart';
import 'package:demopico/core/common/auth/domain/value_objects/email_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/password_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/vulgo_vo.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/user/domain/aplication/validate_credentials.dart';
import 'package:demopico/core/common/auth/domain/entities/user_credentials.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:demopico/features/user/presentation/controllers/profile_view_model.dart';
import 'package:flutter/material.dart';

class AuthViewModelSignUp extends ChangeNotifier {
  static AuthViewModelSignUp? _authUserProvider;

  static AuthViewModelSignUp get getInstance {
    _authUserProvider ??= AuthViewModelSignUp(
      profileViewModel: ProfileViewModel.getInstance,
      validateUserCredentials: ValidateUserCredentials.instance,
      signUp: SignUpUc.instance,
    );
    return _authUserProvider!;
  }

  AuthViewModelSignUp({
    required ValidateUserCredentials validateUserCredentials,
    required ProfileViewModel profileViewModel,
    required SignUpUc signUp,
  })  : _validateUserCredentials = validateUserCredentials,
        _signUpUc = signUp;

  final SignUpUc _signUpUc;
  final ValidateUserCredentials _validateUserCredentials;

  EmailVO? emailField;
  VulgoVo? vulgoField;
  PasswordVo? passwordField;

  String? errorEmail;
  String? errorVulgo;
  String? errorPassword;

  bool isLoading = false;

  void updateFieldEmail(String email) {
    try {
      errorEmail = null;
      emailField = EmailVO(email);
    } on Failure catch (e) {
      errorEmail = e.message;
    }
  }

  void updateFieldVulgo(String vulgo) {
    try {
      vulgoField = VulgoVo(vulgo);
    } on Failure catch (e) {
      errorVulgo = e.message;
    }
  }

  void updateFieldPassword(String newValue) {
    try {
      passwordField = PasswordVo(newValue);
    } on Failure catch (e) {
      errorPassword = e.message;
    }
  }

  bool validadeAllFields() {
    errorEmail = null;
    errorVulgo = null;
    errorPassword = null;

    if (emailField == null) {
      errorEmail = "Email não pode ser nulo";
      return false;
    }
    if (vulgoField == null) {
      errorVulgo = "Vulgo não pode ser nulo";
      return false;
    }
    if (passwordField == null) {
      errorPassword = "Senha não pode ser nula";
      return false;
    }

    return true;
  }

  Future<void> signUp() async {
    //limpando mensagens de erro a cada tentativa para
    // evitar que o erro persista após a alteração
    clearMessageErrors();
    isLoading = true;
    notifyListeners();

    if (!validadeAllFields()) {
      debugPrint("VM - FALHA NA VALIDAÇÃO DOS CAMPOS");
      isLoading = false;
      notifyListeners();
      return;
    }
    try {
      final credentials = NormalUserCredentialsSignUp(
          vulgo: vulgoField!, email: emailField!, password: passwordField!);

      final validCredentials =
          await _validateUserCredentials.validateForSignUp(credentials);
      final newUser = await _signUpUc.execute(validCredentials);

      if (newUser.success) {
        debugPrint("VM - USUÁRIO CRIADO COM SUCESSO");
        AuthViewModelAccount.instance.setCurrentUser = newUser.user!;
        return;
      } else {
        debugPrint("VM - ERRO AO CRIAR USUÁRIO: ${newUser.failure.toString()}");
        FailureServer.showError(newUser.failure!);
      }
    } on Failure catch (e) {
      FailureServer.showError(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearMessageErrors() {
    errorEmail = null;
    errorPassword = null;
    errorVulgo = null;
  }

  @override
  void dispose() {
    clearMessageErrors();
    emailField = null;
    vulgoField = null;
    passwordField = null;
    super.dispose();
  }
}
