import 'package:demopico/core/domain/entities/user_profile.dart';
import 'package:demopico/features/hub/domain/entities/post_hub.dart';
import 'package:demopico/features/hub/domain/interface/interface_post.dart';

class EditarPostagemUseCase {
  final InterfacePost interfacePost;

  EditarPostagemUseCase(this.interfacePost);

  Future<bool> call(PostagemHub postagem, LoggedUser user) async {
    if (postagem.podeAlterar(user.id!)) {
      if(postagem.coteudoValido(postagem.conteudo)){
        interfacePost.editarPostagem(postagem);
        return true;
      }
      return false;
    }
    return false;
  }
}