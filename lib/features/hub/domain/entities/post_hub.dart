
import 'package:demopico/core/domain/entities/user_profile.dart';

class PostagemHub {
  final String id;
  final LoggedUser autor;
  final String conteudo;
  final DateTime data;
  final int curtidas;
  final bool isDonation;
  final bool isEvent;
  final int qntComentarios;
  final Map<LoggedUser, String> comentarios;
  

  PostagemHub({
    required this.id,
    required this.autor, 
    required this.conteudo, 
    required this.data, 
    required this.curtidas,
    required this.isDonation,
    required this.qntComentarios,
    required this.comentarios,
    required this.isEvent});

    bool coteudoValido(String conteudo){
      return conteudo.length <= 200;
    }
    bool podeAlterar(String id){
      return id == autor.id;
    }
  
}