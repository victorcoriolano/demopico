import 'dart:async';

import 'package:demopico/core/common/auth/domain/usecases/get_auth_state.dart';
import 'package:demopico/core/common/auth/domain/usecases/sign_in_email_password_uc.dart';
import 'package:demopico/core/common/auth/domain/usecases/sign_up_uc.dart';
import 'package:demopico/core/common/auth/domain/value_objects/email_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/password_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/vulgo_vo.dart';
import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/user/domain/aplication/validate_credentials.dart';
import 'package:demopico/core/common/auth/domain/entities/user_credentials.dart';
import 'package:demopico/features/user/domain/enums/auth_state.dart';
import 'package:demopico/features/user/domain/enums/identifiers.dart';
import 'package:demopico/features/user/domain/usecases/logout_uc.dart';
import 'package:demopico/features/user/domain/usecases/pegar_id_usuario.dart';
import 'package:demopico/features/user/presentation/controllers/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthViewModelSignIn extends ChangeNotifier {
  static AuthViewModelSignIn? _authUserProvider;

  static AuthViewModelSignIn get getInstance {
    _authUserProvider ??= AuthViewModelSignIn(
        profileViewModel: ProfileViewModel.getInstance,
        loginEmailUc: SignInEmailPasswordUc.instance,
        validateUserCredentials: ValidateUserCredentials.instance,);
    return _authUserProvider!;
  }

  AuthViewModelSignIn(
      {
      required ValidateUserCredentials validateUserCredentials,
      required ProfileViewModel profileViewModel,
      required this.loginEmailUc,})
      : _validateUserCredentials = validateUserCredentials,
        _profileViewModel = profileViewModel;

  final SignInEmailPasswordUc loginEmailUc;
  final ValidateUserCredentials _validateUserCredentials;
  final ProfileViewModel _profileViewModel;

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

  String login = "";
  String password = "";

  bool isLoading = false;


  void changeIsCredential(bool value) {
    identifier = Identifiers.fromIsEmail(value);
    notifyListeners();
  }

  Future<void> signIn() async {
    isLoading = true;
    
    switch (identifier){
      case Identifiers.email:

          final credentials = EmailCredentialsSignIn(identifier: EmailVO(login), senha: PasswordVo(password));
          final validatedCredentials =
            await _validateUserCredentials.validateEmailExist(credentials);
          await loginEmailUc.execute(credentials);
       
      case Identifiers.vulgo:
        final credentials = VulgoPasswordCredentialsSignIn(vulgo: VulgoVo(login), password: PasswordVo(password));
    }

    /* credentials.login = credentials.login.toLowerCase();
    try {
      final validatedCredentials =
          await _validateUserCredentials.validateForLogin(credentials);
      final user = await loginEmailUc.logar(validatedCredentials);
      setIdUser = user.id;
      userDatabaseProvider.setUser = user;
    } on Failure catch (e) {
      getError(e);
    } catch (e) {
      getError(UnknownFailure(unknownError: e));
    } */
  }

  void getError(Failure e, [String? message]) {
    final messageError = message ?? "ERRO";
    Get.snackbar(messageError, e.message);
  }

  void clearMessageErrors() {
    
  }
}
