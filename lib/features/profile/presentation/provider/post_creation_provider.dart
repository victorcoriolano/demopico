
import 'package:demopico/core/common/files/models/file_model.dart';
import 'package:demopico/core/common/util/file_manager/pick_files_uc.dart';
import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/files/models/upload_result_file_model.dart';
import 'package:demopico/core/common/files/services/upload_service.dart';
import 'package:demopico/features/profile/domain/models/post.dart';
import 'package:demopico/features/profile/domain/usecases/create_post_uc.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:flutter/material.dart';

class PostCreationProvider extends ChangeNotifier {

  final CreatePostUc createPostUc;
  final UploadService _uploadService;
  final PickFileUC pickFileUC;

  PostCreationProvider({
    required UploadService uploadService,
    required this.pickFileUC,
    required this.createPostUc,}): _uploadService = uploadService;


  final List<FileModel> _filesModels = [];
  String _description = '';
  String? _selectedSpotId;
  String? _messageError;
  final List<String> _imgUrls = [];
  double progress = 0.0;
  final List<Post> _posts = [];
  
  

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


  Future<void> createPost(UserM user) async{
    try{
      if (user.id == null || user.pictureUrl == null || user.name == null) {
        _messageError = "Usuário inválido";
        throw InvalidUserFailure();
      }
      final uploadResults = _uploadService.uploadFiles(_filesModels);
      uploadResults.map((task) {
        task.listen((event) {
          if (event.state == UploadState.uploading) {
            progress = event.progress;
            notifyListeners();
          } else if (event.state == UploadState.success) {
            _imgUrls.add(event.url!);
            debugPrint("Imagem enviada com sucesso: ${event.url}");
          } else if (event.state == UploadState.failure) {
            _messageError = "Erro ao fazer upload das imagens";
          }
        },
        onDone: () {
          debugPrint("Upload concluido com sucesso");
          
        } 
        );
      });

      final newPost = Post(
        id: "",
        nome: user.name!, 
        userId: user.id!,
        spotID: _selectedSpotId ?? '', 
        urlUserPhoto: user.pictureUrl!, 
        description: description, 
        urlMidia: _imgUrls);
      
      final post = await createPostUc.execute(newPost);
      _posts.add(post);
      clear();
    }on Failure catch (e){
      _messageError = e.message;
      notifyListeners();
    }
  }
  void clear() {
    _filesModels.clear();
    _description = '';
    _selectedSpotId = null;
    _messageError = null;
    _imgUrls.clear();
    progress = 0.0;
    notifyListeners();
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }
}
  