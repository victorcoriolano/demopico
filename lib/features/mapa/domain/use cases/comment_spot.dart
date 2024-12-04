import 'package:demopico/features/mapa/data/services/comment_data_service.dart';
import 'package:demopico/features/mapa/domain/entities/comment.dart';

class CommentSpotUC {
  final CommentRepository commentRepository;

  CommentSpotUC(this.commentRepository);

  Future<void> execulteAdd(Comment comentario)async{
    try{
      await commentRepository.addComment(comentario);

    }catch (e){
      print("Erro aou comentera: $e");
    }
  }

    Future<List<Comment>> execulte(String idPico)async{
    try{
      final listComment = await commentRepository.getCommentsByPeak(idPico);
      return listComment;
    }catch (e){
      print("Erro aou comentera: $e");
      return [];
    }
  }

}