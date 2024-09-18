import 'package:demopico/core/domain/entities/user_profile.dart';
import 'package:demopico/features/hub/domain/entities/post_hub.dart';
import 'package:demopico/features/hub/domain/interface/interface_post.dart';

class CreatePostHub {
  final InterfacePost intarface;
  CreatePostHub(this.intarface);

  Future<bool> callCreate(PostagemHub postagem, LoggedUser? user) async {
    if(user == null){
      // não pissui conta
      return false;
    }
    else {
      intarface.criarPostagem(postagem);
      return true;
    }
  }
}