
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/core/common/files_manager/models/file_model.dart';
import 'package:demopico/core/common/util/file_manager/pick_files_uc.dart';
import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/files_manager/services/upload_service.dart';
import 'package:demopico/features/profile/domain/models/post.dart';
import 'package:demopico/features/profile/domain/usecases/create_post_uc.dart';
import 'package:demopico/features/profile/domain/usecases/get_post_uc.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:flutter/material.dart';

class PostProvider extends ChangeNotifier {

  final CreatePostUc _createPostUc;
  final PickFileUC _pickFileUC;
  final GetPostUc _getPostUc;

  PostProvider({
    required CreatePostUc createPostUc,
    required PickFileUC pickFileUC,
    required GetPostUc getPosts}) 
    : _createPostUc = createPostUc,
      _pickFileUC = pickFileUC,
      _getPostUc = getPosts;


  final List<FileModel> _filesModels = [];
  String _description = '';
  String? _selectedSpotId;
  String? _messageError;
  final List<String> _imgUrls = [];
  double progress = 0.0;
  final List<Post> _posts = [];
  bool _isLoading = false;
  
  

  String get messageError => _messageError ?? '';
  List<FileModel> get filesModels => _filesModels;
  String get description => _description;
  String? get selectedSpotId => _selectedSpotId;
  bool get isLoading => _isLoading;
  List<Post> get post => _posts;
  
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
      _isLoading = true;
      notifyListeners();
      final files = await _pickFileUC.execute();
      filesModels.addAll(files);
      _isLoading = false;
      notifyListeners();
      debugPrint("arquivos selecionados com sucesso");
    } catch (e) {
      debugPrint("Erro ao pegar arquivos");
      _messageError = e.toString();
    }
  }

  


  Future<void> createPost(UserM user) async{
    try{
      _isLoading = true;
      notifyListeners();
      if (user.id == null || user.pictureUrl == null || user.name == null) {
        _messageError = "Usuário inválido";
        _isLoading = false;
        throw InvalidUserFailure();
      }
      final urls = await UploadService.getInstance.uploadFiles(filesModels);
      _imgUrls.addAll(urls);

      if (_imgUrls.isEmpty) {
        _messageError = "Não foi possivel fazer o upload de imagens";
        throw UploadFileFailure();
      }

      // Espera o upload terminar
      final newPost = Post(
        id: "",
        nome: user.name!, 
        userId: user.id!,
        spotID: _selectedSpotId ?? '', 
        urlUserPhoto: user.pictureUrl!, 
        description: description, 
        urlMidia: _imgUrls);
      
      final post = await _createPostUc.execute(newPost);
      _posts.add(post);
      _isLoading = false;
      notifyListeners();
      clear();
    }on Failure catch (e){
      _messageError = e.message;
      notifyListeners();
    }
  }

  Future<void> getPost(String userId) async {
    try {
      _isLoading = true;
      notifyListeners();
      final posts = await _getPostUc.execute(userId);
      _posts.clear();
      _posts.addAll(posts);
      _isLoading = false;
      notifyListeners();
    }on Failure catch (e) {
      _messageError = e.message;
      _isLoading = false;
      notifyListeners();
    }catch (e) {
      _messageError = 'Erro desconhecido ao buscar postagens: ${e.toString()}';
      _isLoading = false;
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
  