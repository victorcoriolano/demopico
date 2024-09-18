
import 'package:demopico/core/domain/entities/user_profile.dart';

class Postagem {
  final LoggedUser autor;
  final String conteudo;
  final DateTime data;
  final List<String> comentarios;
  final int curtidas;
  final bool isDonation;
  final bool isEvent;

  Postagem({
    required this.autor, 
    required this.conteudo, 
    required this.data, 
    required this.comentarios, 
    required this.curtidas,
    required this.isDonation,
    required this.isEvent});

    bool coteudoValido(String conteudo){
      if(conteudo.length <= 200){
        return true;
      }
      return false;
    }
  
}