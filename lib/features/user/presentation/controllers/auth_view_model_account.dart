import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/auth/domain/usecases/change_password_uc.dart';
import 'package:demopico/core/common/auth/domain/usecases/reset_password_uc.dart';
import 'package:demopico/core/common/auth/domain/usecases/delete_account_uc.dart';
import 'package:demopico/core/common/auth/domain/usecases/get_auth_state_uc.dart';
import 'package:demopico/core/common/auth/domain/usecases/logout_uc.dart';
import 'package:demopico/core/common/auth/domain/value_objects/password_vo.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:demopico/core/common/media_management/models/upload_result_file_model.dart';
import 'package:demopico/core/common/media_management/usecases/pick_one_image_uc.dart';
import 'package:demopico/core/common/media_management/usecases/upload_file_uc.dart';
import 'package:demopico/core/common/media_management/usecases/upload_files_uc.dart';
import 'package:demopico/features/profile/domain/usecases/update_profile.dart';
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
        pickAImage: PickOneImageUc.instance,
        uploadFile: UploadFileUC.getInstance,
      );

  AuthViewModelAccount({
    required LogoutUc logoutUc,
    required DeleteAccountUc deleteAccountUc,
    required ResetPasswordUc changePasswordUc,
    required GetCurrentUserUc getAuthState,
    required ChangePasswordUc changePass,
    required PickOneImageUc pickAImage,
    required UploadFileUC uploadFile,
  }): _resetPasswordUc = changePasswordUc,
      _deleteAccountUc = deleteAccountUc,
      _getAuthState = getAuthState,
      _changePasswordUc = changePass,
      _logoutUc = logoutUc,
      _pickOneImageUc = pickAImage,
      _uploadFile = uploadFile;

  final LogoutUc _logoutUc;
  final DeleteAccountUc _deleteAccountUc;
  final ResetPasswordUc _resetPasswordUc;
  final GetCurrentUserUc _getAuthState;
  final ChangePasswordUc _changePasswordUc;
  final PickOneImageUc _pickOneImageUc;
  final UploadFileUC _uploadFile;

  /// inicializando como null object pra não ter ficar fazendo verificações de null toda hora  
  FileModel avatar = NullFileModel();
  FileModel backgroundImage = NullFileModel();
  bool isLoading = false;
  String? avatarUrl;
  String? imageBackGroundUrl;
  
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
      Get.snackbar(
        "Erro", "Ocorreu um erro ao enviar o email, por favor verifique os campos e tente novamente",
        dismissDirection: DismissDirection.down);
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

  /// Update Profile Flow =>
  /// Select new profile photo
  Future<FileModel> selectNewImage(bool isBackGround) async {
    try {
      final selectedFile = await _pickOneImageUc.execute();
      isBackGround ? backgroundImage = selectedFile : avatar = selectedFile;
      return selectedFile;
    } on Failure catch (e){
      FailureServer.showError(e);
      return NullFileModel();
    }
  }
  /// confirmar atualização 
  /// subir para o firestore storage
  Future<UserEntity> uploadFileProfile(FileModel file) async {
    try {
      final streamUpload = _uploadFile.execute(file, "users/avatar/${(_currentUser as UserEntity).id}");
      streamUpload.listen(
        (onData) {
          if (onData.state == UploadState.success){
            debugPrint("Sucesso no upload: ${onData.url}");
            avatarUrl = onData.url;
            final profileUpdated = (_currentUser as UserEntity).profileUser.copyWith(avatar: avatarUrl);
            _currentUser = (_currentUser as UserEntity).copyWith(profileUser: profileUpdated);
          }
        }, 
        onDone: () => debugPrint("Done"),
        onError: (error) {
          debugPrint("Ocorreu um erro ao subir arquivo: ${error.toString()}");
        }
      );
      return _currentUser as UserEntity;
    }on Failure catch (e) {
      FailureServer.showError(e);
      return _currentUser as UserEntity;
    }
  }

  Future<UserEntity> uploadBackGroundImage(FileModel file) async {
    try {
      final streamUpload = _uploadFile.execute(file, "users/backGround/${(_currentUser as UserEntity).id}");
      streamUpload.listen(
        (onData) {
          if (onData.state == UploadState.success){
            debugPrint("Sucesso no upload: ${onData.url}");
            imageBackGroundUrl = onData.url;
            final profileUpdated = (_currentUser as UserEntity).profileUser.copyWith(backgroundPicture: imageBackGroundUrl);
            _currentUser = (_currentUser as UserEntity).copyWith(profileUser: profileUpdated);
            debugPrint((_currentUser as UserEntity).profileUser.backgroundPicture);
          }
        }, 
        onDone: () => debugPrint("Done"),
        onError: (error) {
          debugPrint("Ocorreu um erro ao subir arquivo: ${error.toString()}");
        }
      );
      return _currentUser as UserEntity;
    }on Failure catch (e) {
      FailureServer.showError(e);
      return _currentUser as UserEntity;
    }
  }
  /// atualizar user entity

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
}
