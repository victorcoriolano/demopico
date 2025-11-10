import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/core/common/auth/domain/usecases/reset_password_uc.dart';
import 'package:demopico/core/common/auth/domain/usecases/delete_account_uc.dart';
import 'package:demopico/core/common/auth/domain/usecases/logout_uc.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/media_management/models/file_model.dart';
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
        logoutUc: LogoutUc.getInstance,
      );

  AuthViewModelAccount({
    required LogoutUc logoutUc,
    required DeleteAccountUc deleteAccountUc,
    required ResetPasswordUc changePasswordUc,
  }): _resetPasswordUc = changePasswordUc,
      _logoutUc = LogoutUc.getInstance,
      _deleteAccountUc = deleteAccountUc
      ;

  final LogoutUc _logoutUc;
  final ResetPasswordUc _resetPasswordUc;
  final DeleteAccountUc _deleteAccountUc;


  /// inicializando como null object pra não ter ficar fazendo verificações de null toda hora  
  FileModel avatar = NullFileModel();
  FileModel backgroundImage = NullFileModel();
  bool isLoading = false;
  String? avatarUrl;
  String? imageBackGroundUrl;

  Future<void> logout() async {
     try{
      await _logoutUc.deslogar();
      setCurrentUser = AnonymousUserEntity();
      notifyListeners();
    } on Failure catch (failure){
      FailureServer.showError(failure);
    }

  }
  
  Future<void> resetPasswordFlow(String email) async {
    final isSent = await _resetPasswordUc.sendEmail(email);
    if(isSent){
      Get.snackbar(
      'Atenção',
      'Um link para redefinir sua senha foi enviado para seu e-mail. Por favor, verifique sua caixa de entrada e se necessario a caixa de spam.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: kRed,
      colorText: Colors.white,
      dismissDirection: DismissDirection.down
      );
    } else {
      Get.snackbar(
        "Erro", "Ocorreu um erro ao enviar o email, por favor verifique os campos e tente novamente",
        dismissDirection: DismissDirection.down);
    }
  }

  Future<void> deletarConta() async {
     try{
      if (user is UserEntity) await _deleteAccountUc.execute((user as UserEntity).id);
      setCurrentUser = AnonymousUserEntity();
    } on Failure catch (failure){
      FailureServer.showError(failure);
    }

  }


  User _currentUser = AnonymousUserEntity();

  set setCurrentUser(User user){
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

  UserIdentification? get userIdentification {
    switch (_currentUser) {
      case UserEntity _:
        final thisUser = _currentUser as UserEntity;
        return UserIdentification(
          id: thisUser.id, 
          name: thisUser.displayName.value, 
          profilePictureUrl: thisUser.avatar,); 
      case AnonymousUserEntity _:
        return null;
    }}
}
