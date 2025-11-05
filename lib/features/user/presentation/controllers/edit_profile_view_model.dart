import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/auth/domain/usecases/update_password_uc.dart';
import 'package:demopico/core/common/auth/domain/value_objects/password_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/vulgo_vo.dart';
import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:demopico/core/common/media_management/models/upload_result_file_model.dart';
import 'package:demopico/core/common/media_management/services/upload_service.dart';
import 'package:demopico/core/common/media_management/usecases/pick_one_image_uc.dart';
import 'package:demopico/core/common/media_management/usecases/upload_file_uc.dart';
import 'package:demopico/features/profile/domain/usecases/update_profile.dart';
import 'package:demopico/features/profile/infra/repository/profile_repository.dart';
import 'package:demopico/features/user/domain/usecases/update_data_user_uc.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileViewModel extends ChangeNotifier {
  
    static EditProfileViewModel? _instance;
    // Avoid self instance
    
    static EditProfileViewModel get instance =>
      _instance ??= EditProfileViewModel(
        updateProfile: UpdateProfile(profileDataRepo: ProfileRepositoryImpl.getInstance),
        account: AuthViewModelAccount.instance,
        updatePassword: UpdatePasswordUc.getInstance,
        pickAImage: PickOneImageUc.instance,
        uploadFile: UploadService.getInstance, 
        updateDataUser: UpdateUserUc.getInstance,
      );

  EditProfileViewModel({
    required UpdatePasswordUc updatePassword,
    required PickOneImageUc pickAImage,
    required UpdateProfile updateProfile,
    required UploadService uploadFile,
    required UpdateUserUc updateDataUser,
    required AuthViewModelAccount account,
  }): _updatePasswordUc = updatePassword,
      _pickOneImageUc = pickAImage,
      _uploadFile = uploadFile,
      _updateProfile = updateProfile,
      _account = account,
      _updateUser = updateDataUser;


  final UpdatePasswordUc _updatePasswordUc;
  final PickOneImageUc _pickOneImageUc;
  final UploadService _uploadFile;
  final AuthViewModelAccount _account;
  final UpdateProfile _updateProfile;
  final UpdateUserUc _updateUser;

  /// inicializando como null object pra não ter ficar fazendo verificações de null toda hora  
  FileModel avatar = NullFileModel();
  FileModel backgroundImage = NullFileModel();

  VulgoVo? newVulgo;
  String? newBio;

  bool isLoading = false;

  Future<FileModel> selectAvatar() async {
    try {
      final selectedFile = await _pickOneImageUc.execute();
      if (selectedFile.contentType == ContentType.unavailable) throw InvalidFormatFileFailure();
      avatar = selectedFile;
      debugPrint(avatar.runtimeType.toString());
      return selectedFile;
    } on Failure catch (e){
      FailureServer.showError(e);
      return NullFileModel();
    }
  }

  Future<FileModel> selectBackgroundPicture() async {
    try {
      final selectedFile = await _pickOneImageUc.execute();
      if (selectedFile.contentType == ContentType.unavailable) throw InvalidFormatFileFailure();
      debugPrint(backgroundImage.runtimeType.toString());
      backgroundImage = selectedFile;
      return selectedFile;
    } on Failure catch (e){
      FailureServer.showError(e);
      return NullFileModel();
    }
  }  

  Future<String?> uploadAvatar() async {
    try {
      debugPrint("Chamou o upload do avatar, avatar é null ?${avatar is NullFileModel}");
      if (avatar is NullFileModel) return null;
      debugPrint("Fazendo upload de avatar");
      return _uploadFile.uploadAFileWithoutStream(avatar, "users/photos/avatar/${(_account.user as UserEntity).id}");
    } catch (e){
      debugPrint("Erro ao fazer o upload do avatar: $e");
      return null;
    }
  }

  Future<String?> uploadBackgroundImage() async {
    try {
      if (backgroundImage is NullFileModel) return null;
       return _uploadFile.uploadAFileWithoutStream(
        backgroundImage, 
        "users/photos/backgroundProfiles/${(_account.user as UserEntity).id}");
    } catch (e){
      debugPrint("Erro ao fazer o upload do avatar: $e");
      return null;
    }
  }

  Future<void> updatePassword(PasswordVo newPassword) async {
    try {
      await _updatePasswordUc.execute(newPassword);
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

  bool get hasNewImages {
    return avatar is! NullFileModel 
      || backgroundImage is! NullFileModel;
  }

  Future<void> updateAll() async {
    isLoading = true;
    notifyListeners();
    UserEntity originalUser = _account.user as UserEntity;
    UserEntity userModificado = originalUser.copyWith();
    try {
      // verifica se alguma foto foi alterada
      final (urlAvatar, backgroundImageUrl) = await ( 
        uploadAvatar(),
        uploadBackgroundImage(),
      ).wait;

      if (urlAvatar != null){
        final profileUpdated = userModificado.profileUser.copyWith(avatar: urlAvatar);
        userModificado = userModificado.copyWith(profileUser: profileUpdated, avatar: urlAvatar);
      }
        
      if (backgroundImageUrl != null){
          final profileUpdated = userModificado.profileUser.copyWith(backgroundPicture: backgroundImageUrl);
          userModificado = userModificado.copyWith(profileUser: profileUpdated,);
      }

      // verify text changes as update entity
      if (newVulgo != null) userModificado = userModificado.copyWith(displayName: newVulgo);
      if (newBio != null) {
        final profileUpdated = userModificado.profileUser.copyWith(description: newBio);
        userModificado = userModificado.copyWith(profileUser: profileUpdated);
      } 

      // finally uploads to the database if the data is really different
      if (userModificado != _account.user) {
        final result = await _updateProfile.execute(userModificado.profileUser);
        if (result.success) {
          await _updateUser.updateOnlyField(id: userModificado.id, nameField: "avatar", data: userModificado.avatar);
          debugPrint("Perfil atualizado com sucesso");
          _account.setCurrentUser = userModificado;
        } else {
          throw result.failure!;
        }
      }
    } on Failure catch (e) {
      FailureServer.showError(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  
}