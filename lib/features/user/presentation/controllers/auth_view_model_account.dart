import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/auth/domain/usecases/change_password_uc.dart';
import 'package:demopico/core/common/auth/domain/usecases/reset_password_uc.dart';
import 'package:demopico/core/common/auth/domain/usecases/delete_account_uc.dart';
import 'package:demopico/core/common/auth/domain/usecases/get_auth_state_uc.dart';
import 'package:demopico/core/common/auth/domain/usecases/logout_uc.dart';
import 'package:demopico/core/common/auth/domain/value_objects/password_vo.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/user/domain/enums/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';

class AuthViewModelAccount extends ChangeNotifier {

    static AuthViewModelAccount? _instance;
    // Avoid self instance
    
    static AuthViewModelAccount get instance =>
      _instance ??= AuthViewModelAccount(
        changePasswordUc: ResetPasswordUc.getInstance,
        deleteAccountUc: DeleteAccountUc.getInstance,
        getAuthState: GetCurrentUserUc.instance,
        logoutUc: LogoutUc.getInstance,
        changePass: ChangePasswordUc.getInstance,
      );

  AuthViewModelAccount({
    required LogoutUc logoutUc,
    required DeleteAccountUc deleteAccountUc,
    required ResetPasswordUc changePasswordUc,
    required GetCurrentUserUc getAuthState,
    required ChangePasswordUc changePass,
  }): _resetPasswordUc = changePasswordUc,
      _deleteAccountUc = deleteAccountUc,
      _getAuthState = getAuthState,
      _changePasswordUc = changePass,
      _logoutUc = logoutUc;

  final LogoutUc _logoutUc;
  final DeleteAccountUc _deleteAccountUc;
  final ResetPasswordUc _resetPasswordUc;
  final GetCurrentUserUc _getAuthState;
  final ChangePasswordUc _changePasswordUc;
  
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
  
  Future<void> resetPasswordFlow(String email) async {
    final isSent = await _resetPasswordUc.sendEmail(email);
    if(isSent){
      Get.snackbar(
      'Atenção',
      'Um link para redefinir sua senha foi enviado para seu e-mail. Por favor, verifique sua caixa de entrada e também a caixa de spam.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blueAccent,
      colorText: Colors.white,
      dismissDirection: DismissDirection.down
      );
    } else {
      Get.snackbar("Erro", "Ocorreu um erro ao enviar o email, por favor verifique os campos e tente novamente",dismissDirection: DismissDirection.down);
    }
  }

  Future<void> changePasswordFlow(PasswordVo newPassword) async {
    try {
      await _changePasswordUc.execute(newPassword);
    
      Get.snackbar(
      'Atenção',
      'Um link para redefinir sua senha foi enviado para seu e-mail. Por favor, verifique sua caixa de entrada.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blueAccent,
      colorText: Colors.white,
      dismissDirection: DismissDirection.down
      );  
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
    
  }

 /*  UserEntity? getCurrentUser(){
    final authstate = _getAuthState.execute();
    switch (authstate){
      
      case AuthAuthenticated():
        debugPrint("USUÁRIO AUTENTICADO");
        return authstate.user;
      case AuthUnauthenticated():
        debugPrint("USUÁRIO NÃO AUTENTICADO");
        return null;
    }
  }
 */
  User _currentUser = AnonymousUserEntity();

  set currentUser(User user){
    _currentUser = user;
    notifyListeners();
  }

  User get user => _currentUser;

  AuthState get authState {
    switch (_currentUser) {
      case UserEntity _:
        return AuthAuthenticated(user: _currentUser as UserEntity); 
      case AnonymousUserEntity _:
        return AuthUnauthenticated();
    }
  }
}
