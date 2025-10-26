
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:demopico/core/common/media_management/usecases/pick_one_image_uc.dart';
import 'package:demopico/features/profile/presentation/object_for_only_view/suggestion_profile.dart';
import 'package:flutter/material.dart';

class CreateCollectiveViewModel extends ChangeNotifier {

  final PickOneImageUc _pickFileUC;

  CreateCollectiveViewModel({
    required PickOneImageUc pickFile,
  }): _pickFileUC = pickFile;

  List<UserIdentification> members = [];
  FileModel photoCollective = NullFileModel();

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

  

}