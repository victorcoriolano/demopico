import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/auth/domain/usecases/change_password_uc.dart';
import 'package:demopico/core/common/auth/domain/usecases/delete_account_uc.dart';
import 'package:demopico/core/common/auth/domain/usecases/get_auth_state_uc.dart';
import 'package:demopico/core/common/auth/domain/usecases/logout_uc.dart';
import 'package:demopico/core/common/auth/infra/repositories/firebase_auth_repository.dart';
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
        changePasswordUc: ChangePasswordUc.getInstance,
        deleteAccountUc: DeleteAccountUc.getInstance,
        getAuthState: GetCurrentUserUc.instance,
        logoutUc: LogoutUc.getInstance,
      );

  AuthViewModelAccount({
    required LogoutUc logoutUc,
    required DeleteAccountUc deleteAccountUc,
    required ChangePasswordUc changePasswordUc,
    required GetCurrentUserUc getAuthState,
  }): _changePasswordUc = changePasswordUc,
      _deleteAccountUc = deleteAccountUc,
      _getAuthState = getAuthState,
      _logoutUc = logoutUc;

  final LogoutUc _logoutUc;
  final DeleteAccountUc _deleteAccountUc;
  final ChangePasswordUc _changePasswordUc;
  final GetCurrentUserUc _getAuthState;
  
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
