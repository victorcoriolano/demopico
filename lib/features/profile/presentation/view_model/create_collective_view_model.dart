
import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:demopico/core/common/media_management/services/upload_service.dart';
import 'package:demopico/core/common/media_management/usecases/pick_one_image_uc.dart';
import 'package:demopico/features/profile/domain/models/profile_user.dart';
import 'package:demopico/features/profile/domain/usecases/create_collective_uc.dart';
import 'package:demopico/features/profile/presentation/object_for_only_view/suggestion_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCollectiveViewModel extends ChangeNotifier {

  final PickOneImageUc _pickFileUC;
  final CreateCollectiveUc _createCollectiveUc;

  CreateCollectiveViewModel({
    required CreateCollectiveUc createUC,
    required PickOneImageUc pickFile,
  }): _pickFileUC = pickFile, _createCollectiveUc = createUC;

  List<UserIdentification> members = [];
  FileModel photoCollective = NullFileModel();
  String nameCollective = '';
  

  void addMember(SuggestionProfile suggestion){
    final user = UserIdentification(
      id: suggestion.idUser, name: suggestion.name, profilePictureUrl: suggestion.photo);
    if (members.contains(user)) return;
    members.add(user);
    notifyListeners();
  }

  void removeMember(UserIdentification user){
    members.remove(user);
    notifyListeners();
  }

  Future<void> addImage() async {
    try { 
      photoCollective = await _pickFileUC.execute();
      notifyListeners(); 
    } on Failure catch (e){
      FailureServer.showError(e);
    }
  } 

  bool validateForCreate(){
    return photoCollective is! NullFileModel && nameCollective.isNotEmpty;
  }

  Future<void> createCollective(Profile profile) async {
    if (!validateForCreate()){
      FailureServer.showError(OtherError(message: "Preencha corretamente os campos"));
      return;
    }
    try{
      final url = await UploadService.getInstance.uploadAFileWithoutStream(photoCollective, "collectives/photos");
      final guests = members.map((u) => u.id).toList();
      final userIdentification = UserIdentification(
        id: profile.userID, name: profile.displayName, profilePictureUrl: profile.avatar);
      final newCollective = ColetivoEntity.initial(nameCollective, userIdentification, url, guests);
      final collective = await _createCollectiveUc.execute(newCollective, profile.idColetivos);
      debugPrint("Coletivo criado com sucesso: $collective");
      Get.snackbar(
      'Sucesso',
      'Coletivo ${collective.nameColetivo} criado com sucesso ',
        snackPosition: SnackPosition.TOP  ,
        backgroundColor: Colors.blueAccent,
        colorText: Colors.white,
        dismissDirection: DismissDirection.down
      );
      Get.back();


      /// TODO: IMPLEMENTAR ADIÇÃO DE USUÁRIOS NO COLETIVO
      /// TODO: IMPLEMENTAR SOLICITAÇÃO DE ENTRADA DE USUÁRIOS NO COLETIVO
      /// TODO: IMPLEMENTAR INFRAESTRUTURA DE NOTIFICAÇÕES
    } on Failure catch (failure) {
      FailureServer.showError(failure);
    }
  }
} 