import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:demopico/core/common/media_management/usecases/pick_mult_files_uc.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/media_management/services/upload_service.dart';
import 'package:demopico/core/common/media_management/usecases/pick_video_uc.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/profile/domain/models/post.dart';
import 'package:demopico/features/profile/domain/usecases/create_post_uc.dart';
import 'package:demopico/features/profile/presentation/object_for_only_view/media_url_item.dart';
import 'package:demopico/features/profile/presentation/view_model/collective_view_model.dart';
import 'package:demopico/features/user/domain/enums/type_post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostCollectiveViewModel extends ChangeNotifier {
  //TODO: Adicionar lógica de cache de imagens e videos para otimizar o carregamento

  final CreatePostUc _createPostUc;
  final PickFileUC _pickFileUC;
  final PickVideoUC _pickVideoUC;

  PostCollectiveViewModel(
      {
      required CreatePostUc createPostUc,
      required PickFileUC pickFileUC,
      required PickVideoUC pickVideo})
      : _createPostUc = createPostUc,
        _pickVideoUC = pickVideo,
        _pickFileUC = pickFileUC;

  final List<FileModel> _videos = [];
  final List<FileModel> _images = [];
  FileModel? _rec;

  String _description = '';
  Pico? _selectedSpotId;
  final List<String> _imgUrls = [];
  final List<String> _videoUrls = [];
  final List<UserIdentification> _users = [];
  final List<Pico> _spots = []; 
  double progress = 0.0;
  bool _isLoading = false;

  FileModel? get rec => _rec;
  List<FileModel> get filesModels => _pickFileUC.listFiles;
  String get description => _description;
  Pico? get selectedSpotId => _selectedSpotId;
  bool get isLoading => _isLoading;
  List<UserIdentification> get mentionedUsers => _users;
  List<Pico> get spots => _spots;


  void removeMedia(FileModel file) {
      _pickFileUC.listFiles.remove(file);    
      notifyListeners();
  }

  void updateDescription(String newDescription) {
    _description = newDescription;
    notifyListeners();
  }

  void selectSpot(Pico? spotId) {
    _selectedSpotId = spotId;
    notifyListeners();
  }

  void addMentionedUser(UserIdentification user) {
    _users.add(user);
    notifyListeners();
  }

  void removeMentionedUser(UserIdentification user) {
    _users.remove(user);
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

  void resetVideo(){
    _rec = null;
    notifyListeners();
  }

  //get media
  Future<void> getFiles() async {
    try {
      await _pickFileUC.execute();
      debugPrint("Adicionou: ${_pickFileUC.listFiles.length} na lista e arquivos selecionados");
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

  void mapearFiles(TypePost typePost){
    if (typePost == TypePost.fullVideo){
      _videos.add(_rec!);
      return;
    }
    
    for (var file in _pickFileUC.listFiles) {
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

  
  Future<void> createPost(UserEntity user, TypePost type, ColetivoEntity coletivo) async {
    try {
      _isLoading = true;
      notifyListeners();

      mapearFiles(type);

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
          nome: user.displayName.value,
          userId: user.id,
          spotID: _selectedSpotId?.id ?? '',
          avatar: user.avatar,
          urlVideos: _videoUrls.isEmpty ? null : _videoUrls,
          description: description,
          urlImages: _imgUrls,
          profileRelated: coletivo.id, 
          spotsIds: _selectedSpotId != null ? [_selectedSpotId!.id] : [],
          mentionedUsers: _users.map((e) => e.id).toList(),
          likedBy: [],
      );

      final post = await _createPostUc.execute(newPost, coletivo);
      CollectiveViewModel.instance.coletivo = coletivo.copyWith(publications: [...coletivo.publications, post]);
      debugPrint("postagens atuais do coletivo: ${CollectiveViewModel.instance.coletivo.publications.length}");
      _isLoading = false;
      notifyListeners();
      clear();
    } on Failure catch (e) {
      debugPrint("Erro ao criar postagem: $e");
      getError(e);
      _isLoading = false;
      notifyListeners();
    }
  }
  


  void clear() {
    _pickFileUC.listFiles.clear();
    _description = '';
    _selectedSpotId = null;
    _videos.clear();
    _images.clear();
    _users.clear();
    _spots.clear();
    progress = 0.0;
    notifyListeners();
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }
}
