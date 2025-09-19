import 'package:demopico/core/common/auth/domain/usecases/change_password_uc.dart';
import 'package:demopico/core/common/auth/domain/usecases/delete_account_uc.dart';
import 'package:demopico/core/common/auth/domain/usecases/get_auth_state_uc.dart';
import 'package:demopico/core/common/auth/domain/usecases/logout_uc.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';

class AuthViewModelAccount extends ChangeNotifier {
  AuthViewModelAccount({
    required LogoutUc logoutUc,
    required DeleteAccountUc deleteAccountUc,
    required ChangePasswordUc changePasswordUc,
    required GetAuthStateUc getAuthState,
  }): _changePasswordUc = changePasswordUc,
      _deleteAccountUc = deleteAccountUc,
      _getAuthState = getAuthState,
      _logoutUc = logoutUc;

  final LogoutUc _logoutUc;
  final DeleteAccountUc _deleteAccountUc;
  final ChangePasswordUc _changePasswordUc;
  final GetAuthStateUc _getAuthState;
  
  Future _handleAction(Function execute) async {
    try{
      return await execute();
    } on Failure catch (failure){
      FailureServer.showError(failure);
    }
  }

  Future<void> logout() async {
    await _handleAction(_logoutUc.deslogar);
  }
  
  Future<void> changePassword() async {
    final isSent = await _handleAction(_changePasswordUc.sendEmail);
    if(isSent){
      Get.snackbar("Email enviado com sucesso", "Verifique sua caixa de entrada");
    } else {
      Get.snackbar("Erro", "Ocorreu um erro ao enviar o email");
    }
  }
}
