import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/core/common/files_manager/models/file_model.dart';
import 'package:demopico/core/common/util/file_manager/pick_files_uc.dart';
import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/files_manager/services/upload_service.dart';
import 'package:demopico/core/common/util/file_manager/pick_video_uc.dart';
import 'package:demopico/features/profile/domain/models/post.dart';
import 'package:demopico/features/profile/domain/usecases/create_post_uc.dart';
import 'package:demopico/features/profile/domain/usecases/delete_post_uc.dart';
import 'package:demopico/features/profile/domain/usecases/get_post_uc.dart';
import 'package:demopico/features/profile/domain/usecases/update_post_uc.dart';
import 'package:demopico/features/profile/presentation/view_objects/media_url_item.dart';
import 'package:demopico/features/user/domain/enums/type_post.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostProvider extends ChangeNotifier {
  //TODO: Adicionar lógica de cache de imagens e videos para otimizar o carregamento

  final CreatePostUc _createPostUc;
  final PickFileUC _pickFileUC;
  final PickVideoUC _pickVideoUC;
  final GetPostUc _getPostUc;
  final DeletePostUc _deletePostUc;
  final UpdatePostUc _updateUc;

  PostProvider(
      {required DeletePostUc deleteUc,
      required CreatePostUc createPostUc,
      required PickFileUC pickFileUC,
      required GetPostUc getPosts,
      required UpdatePostUc updateUc,
      required PickVideoUC pickVideo})
      : _createPostUc = createPostUc,
        _pickVideoUC = pickVideo,
        _pickFileUC = pickFileUC,
        _getPostUc = getPosts,
        _deletePostUc = deleteUc,
        _updateUc = updateUc;

  final List<FileModel> _filesModels = [];
  final List<FileModel> _videos = [];
  final List<FileModel> _images = [];
  late FileModel _rec;

  String _description = '';
  String? _selectedSpotId;
  final List<String> _imgUrls = [];
  final List<String> _videoUrls = [];
  double progress = 0.0;
  final List<Post> _posts = [];
  final List<Post> _fullVideoPosts = [];
  bool _isLoading = false;

  FileModel get rec => _rec;
  List<FileModel> get filesModels => _filesModels;
  String get description => _description;
  String? get selectedSpotId => _selectedSpotId;
  bool get isLoading => _isLoading;
  List<Post> get post => _posts;
  List<Post> get fullVideos => _fullVideoPosts;

  void removeMedia(FileModel file) {
      _filesModels.remove(file);  
      _pickFileUC.listFiles.remove(file);    
      notifyListeners();
  }

  void updateDescription(String newDescription) {
    _description = newDescription;
    notifyListeners();
  }

  void selectSpot(String? spotId) {
    _selectedSpotId = spotId;
    notifyListeners();
  }

  Future<void> getVideo() async {
    
    try{
      _rec = await _pickVideoUC.execute();
      
      notifyListeners();
    }on Failure catch (e){
      getError(e);
    } 
  }

  //get media
  Future<void> getFiles() async {
    try {
      _filesModels.clear();
      final files = await _pickFileUC.execute();
      _filesModels.addAll(files);
      debugPrint(
          "Adicionou: ${_filesModels.length} na lista e arquivos selecionados");

      

      notifyListeners();
      debugPrint("arquivos selecionados com sucesso");
    } on Failure catch (e) {
      debugPrint("Erro ao pegar arquivos");
      getError(e);
    }
  }

  void getError(Failure e){
    Get.snackbar(
      "Erro", 
      e.message, 
      colorText: kBlack, 
      icon: Icon(Icons.error_outline)
    );
  }

  List<MediaUrlItem> getMediaItemsFor(Post post) {
    final items = <MediaUrlItem>[];

    items.addAll(post.urlImages
        .map((e) => MediaUrlItem(url: e, contentType: MediaType.image)));
    items.addAll(post.urlVideos
            ?.map((e) => MediaUrlItem(url: e, contentType: MediaType.video)) ??
        []);

    return items;
  }

  void mapearFiles(){
    for (var file in _filesModels) {
        // Mapeando os arquivos para imagens e vídeos
        debugPrint("mapeando arquivos");
        if (file.contentType.isVideo) {
          _videos.add(file);
          debugPrint("Arquivo de vídeo adicionado: ${file.fileName}");
        } else if (file.contentType.isImage) {
          _images.add(file);
          debugPrint("Arquivo de imagem adicionado: ${file.fileName}");
        } else {
          debugPrint("Não foi possivel mapear o arquivo: ${file.fileName}");
        }
      }
  }

  // Gateway carregar postagem para ui
  // retorna caso a requisição já tenha sido feita postagens ja tenha sido feitas
  Future<void> loadPosts(String userId) async {
    if (_posts.isNotEmpty) return;
    getPosts(userId);
  }

  Future<void> deletePost(Post postagem) async {
    _isLoading = true;
    notifyListeners();

    final urls = <String>[];
    urls.addAll(postagem.urlImages);
    if (postagem.urlVideos != null) urls.addAll(postagem.urlVideos!);
    try{
      await _deletePostUc.execute(postagem.id, urls);
      _isLoading = false;
      notifyListeners();
    } on Failure catch (e) {
      getError(e);
      _isLoading = false;
      notifyListeners();
    }finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createPost(UserM user, TypePost type) async {
    try {
      _isLoading = true;
      notifyListeners();
      if (user.id == null || user.pictureUrl == null || user.name == null) {
        getError(InvalidUserFailure());
        _isLoading = false;        
      }

      mapearFiles();

      //cria urls separadas para imagens e vídeos
      final urlsimages =
          await UploadService.getInstance.uploadFiles(_images, "posts/images");
      _imgUrls.addAll(urlsimages);

      if (_videos.isNotEmpty) {
        final urlvideos = await UploadService.getInstance
            .uploadFiles(_videos, "posts/videos");
        _videoUrls.addAll(urlvideos);
      }

      final newPost = Post(
          id: "",
          typePost: type,
          nome: user.name!,
          userId: user.id!,
          spotID: _selectedSpotId ?? '',
          urlUserPhoto: user.pictureUrl!,
          urlVideos: _videoUrls.isEmpty ? null : _videoUrls,
          description: description,
          urlImages: _imgUrls);

      final post = await _createPostUc.execute(newPost);
      _posts.add(post);
      _isLoading = false;
      notifyListeners();
      clear();
    } on Failure catch (e) {
      getError(e);
      _isLoading = false;
      notifyListeners();
    }
  }

  

  Future<void> getPosts(String userId) async {
    try {
      _isLoading = true;
      notifyListeners();
      final myPosts = await _getPostUc.execute(userId);
      _posts.clear();
      if (myPosts.isEmpty) {
        debugPrint("Nenhum post encontrado no banco de dados");        
        _isLoading = false;
        notifyListeners();
        return;
      }
      _posts.addAll(myPosts.where((post) => post.typePost == TypePost.post));
      _fullVideoPosts.addAll(myPosts.where((post) => post.typePost == TypePost.fullVideo));
      _isLoading = false;
      notifyListeners();
    } on Failure catch (e) {
      getError(e);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      getError(UnknownFailure(unknownError: e));
      _isLoading = false;
      notifyListeners();
    }
  }

  
  Future<void> updatePost(Post updatedPost, int index) async {
    try{
      _posts.removeAt(index);
      final result = await _updateUc.execute(updatedPost);
      _posts.add(result);
      notifyListeners();
    } on Failure catch (e) {
      getError(e);
    } catch (e, st) {
      debugPrint("Falha desconhecida ao atualizar postagem: $e, $st");
      getError(UnknownFailure(unknownError: e, stackTrace: st));
    }
  }

  void clear() {
    _filesModels.clear();
    _description = '';
    _selectedSpotId = null;
    _videos.clear();
    _images.clear();
    progress = 0.0;
    notifyListeners();
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }
}
