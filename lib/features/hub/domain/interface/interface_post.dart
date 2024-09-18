import 'package:demopico/features/hub/domain/entities/post_hub.dart';

abstract class InterfacePost {
  Future<void> criarPostagem(PostagemHub postagem);
  Future<void> deletarPostagem(String postagemId);
  Future<void> editarPostagem(PostagemHub postagem);
  Future<List<PostagemHub>> listarPostagens();
  Future<PostagemHub> getPostagemById(String id);
  Future<void> filtrarPostagem(String parametro);

}