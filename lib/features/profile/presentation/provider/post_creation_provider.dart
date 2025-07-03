
import 'package:demopico/core/common/files/models/file_model.dart';
import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/usecases/pick_files_uc.dart';
import 'package:demopico/core/common/usecases/save_image_uc.dart';
import 'package:demopico/features/profile/domain/models/post.dart';
import 'package:demopico/features/profile/domain/usecases/create_post_uc.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:flutter/material.dart';

class PostCreationProvider extends ChangeNotifier {

  final CreatePostUc createPostUc;
  final PickFileUC pickFileUC;
  final SaveImageUC saveImageUC;

  PostCreationProvider({
    required this.saveImageUC,
    required this.createPostUc, 
    required this.pickFileUC});


  final List<FileModel> _filesModels = [];
  String _description = '';
  String? _selectedSpotId;
  String? _messageError;

  String get messageError => _messageError ?? '';
  List<FileModel> get filesModels => _filesModels;
  String get description => _description;
  String? get selectedSpotId => _selectedSpotId;


  void removeMedia(int index) {
    if (index >= 0 && index < _filesModels.length) {
      _filesModels.removeAt(index);
      notifyListeners();
    }
  }

  bool get hasError => _messageError != null;

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
  Future<Post> createPost(UserM user) async{
    try{
      if (user.id == null || user.pictureUrl == null || user.name == null) {
        _messageError = "Usuário inválido";
        throw InvalidUserFailure();
      }

      final newPost = Post(
        nome: user.name!, 
        userId: user.id!, 
        urlUserPhoto: user.pictureUrl!, 
        description: description, 
        urlMidia: urlMidia);
      
      await createPostUc.execute(newPost)
    }on Failure catch (e){
      _messageError = e.message;
      notifyListeners();
    }
  }

}
  