import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/auth/domain/usecases/change_password_uc.dart';
import 'package:demopico/core/common/auth/domain/usecases/delete_account_uc.dart';
import 'package:demopico/core/common/auth/domain/usecases/reset_password_uc.dart';
import 'package:demopico/core/common/auth/domain/value_objects/password_vo.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:demopico/core/common/media_management/models/upload_result_file_model.dart';
import 'package:demopico/core/common/media_management/usecases/pick_one_image_uc.dart';
import 'package:demopico/core/common/media_management/usecases/upload_file_uc.dart';
import 'package:demopico/features/profile/domain/usecases/update_profile.dart';
import 'package:demopico/features/profile/infra/repository/profile_repository.dart';
import 'package:demopico/features/user/domain/usecases/update_data_user_uc.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAccountViewModel extends ChangeNotifier {
  
    static EditAccountViewModel? _instance;
    // Avoid self instance
    
    static EditAccountViewModel get instance =>
      _instance ??= EditAccountViewModel(
        updateProfile: UpdateProfile(profileDataRepo: ProfileRepositoryImpl.getInstance),
        account: AuthViewModelAccount.instance,
        changePasswordUc: ResetPasswordUc.getInstance,
        deleteAccountUc: DeleteAccountUc.getInstance,
        changePass: ChangePasswordUc.getInstance,
        pickAImage: PickOneImageUc.instance,
        uploadFile: UploadFileUC.getInstance, 
        updateDataUser: UpdateUserUc.getInstance,
      );

  EditAccountViewModel({
    required DeleteAccountUc deleteAccountUc,
    required ResetPasswordUc changePasswordUc,
    required ChangePasswordUc changePass,
    required PickOneImageUc pickAImage,
    required UpdateProfile updateProfile,
    required UploadFileUC uploadFile,
    required UpdateUserUc updateDataUser,
    required AuthViewModelAccount account,
  }): _resetPasswordUc = changePasswordUc,
      _deleteAccountUc = deleteAccountUc,
      _changePasswordUc = changePass,
      _pickOneImageUc = pickAImage,
      _uploadFile = uploadFile,
      _updateProfile = updateProfile,
      _account = account,
      _updateUser = updateDataUser;


  final DeleteAccountUc _deleteAccountUc;
  final ResetPasswordUc _resetPasswordUc;
  final ChangePasswordUc _changePasswordUc;
  final PickOneImageUc _pickOneImageUc;
  final UploadFileUC _uploadFile;
  final AuthViewModelAccount _account;
  final UpdateProfile _updateProfile;
  final UpdateUserUc _updateUser;

  /// inicializando como null object pra não ter ficar fazendo verificações de null toda hora  
  FileModel avatar = NullFileModel();
  FileModel backgroundImage = NullFileModel();
  bool isLoading = false;
  String? avatarUrl;
  String? imageBackGroundUrl;



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


  Future<UserEntity> uploadFileProfile(FileModel file) async {
    try {
      final streamUpload = _uploadFile.execute(file, "users/avatar/${(_account.user as UserEntity).id}");
      streamUpload.listen(
        (onData) {
          if (onData.state == UploadState.success){
            debugPrint("Sucesso no upload: ${onData.url}");
            avatarUrl = onData.url;
            final profileUpdated = (_account.user as UserEntity).profileUser.copyWith(avatar: avatarUrl);
            _account.setCurrentUser = (_account.user as UserEntity).copyWith(profileUser: profileUpdated);
          }
        }, 
        onDone: () => debugPrint("Done"),
        onError: (error) {
          debugPrint("Ocorreu um erro ao subir arquivo: ${error.toString()}");
        }
      );
      return _account.user as UserEntity;
    }on Failure catch (e) {
      FailureServer.showError(e);
      return _account.user as UserEntity;
    }
  }

  
  Future<void> changePasswordFlow(PasswordVo newPassword) async {
    try {
      await _changePasswordUc.execute(newPassword);
      Get.snackbar(
      'Atenção',
      'Senha Redefinida',
      snackPosition: SnackPosition.TOP  ,
      backgroundColor: Colors.blueAccent,
      colorText: Colors.white,
      dismissDirection: DismissDirection.down
      );  
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
  }

  Future<void> update() async {

  }
}