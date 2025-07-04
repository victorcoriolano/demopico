
import 'package:demopico/core/common/data/models/file_model.dart';
import 'package:demopico/core/common/util/file_manager/pick_files_uc.dart';
import 'package:demopico/features/profile/domain/usecases/create_post_uc.dart';
import 'package:flutter/material.dart';

class PostCreationProvider extends ChangeNotifier {

  final CreatePostUc createPostUc;
  final PickFileUC pickFileUC;

  PostCreationProvider({
    required this.createPostUc, 
    required this.pickFileUC});


  final List<FileModel> _filesModels = [];
  String _description = '';
  String? _selectedSpotId;
  String? _messageError;

  List<FileModel> get filesModels => _filesModels;
  String get description => _description;
  String? get selectedSpotId => _selectedSpotId;

  void removeMedia(int index) {
    if (index >= 0 && index < _filesModels.length) {
      _filesModels.removeAt(index);
      notifyListeners();
    }
  }

  void updateDescription(String newDescription) {
    _description = newDescription;
    notifyListeners();
  }

  void selectSpot(String? spotId) {
    _selectedSpotId = spotId;
    notifyListeners();
  }

  //get media
  void getFile() async {
    try{
      final files = await pickFileUC.execute();
      filesModels.addAll(files);
      notifyListeners();
      debugPrint("arquivos selecionados com sucesso");
    } catch (e) {
      debugPrint("Erro ao pegar arquivos");
      _messageError = e.toString();
    }
    
  }
}
  