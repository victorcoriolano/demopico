import 'package:demopico/core/domain/entities/user_profile.dart';
import 'package:demopico/features/hub/domain/interface/interface_post.dart';

class DeletePostHub {
  final InterfacePost interfacePost;

  DeletePostHub(this.interfacePost);

  Future<bool> callDelete(String idPostagem ,LoggedUser userWantDelete) async{
    //pegar post atraves do email
    final postagem = await interfacePost.getPostagemById(idPostagem);
    //verifica se o usuário que quer deletar pode deletar
    if(postagem.podeAlterar(userWantDelete.id!)){
      interfacePost.deletarPostagem(idPostagem);
      return true;
    }
    else{
      return false;
    }
  }

}