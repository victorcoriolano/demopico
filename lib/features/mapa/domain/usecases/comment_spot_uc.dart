import 'package:demopico/features/mapa/domain/entities/comment.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_comment_repository.dart';

class CommentSpotUC {
  final ICommentRepository commentRepository;

  CommentSpotUC(this.commentRepository);

  Future<void> execulteAdd(Comment comentario)async{
    try{
      await commentRepository.addComment(comentario);

    }catch (e){
      throw Exception("Erro ao comentar: $e");
    }
  }

    Future<List<Comment>> execulte(String idPico)async{
    try{
      final listComment = await commentRepository.getCommentsByPeak(idPico);
      return listComment;
    }catch (e){
      return [];
    }
  }

}