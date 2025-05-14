import 'package:demopico/features/mapa/data/services/firebase_comment_service.dart';
import 'package:demopico/features/mapa/domain/entities/comment.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_comment_repository.dart';

class CommentSpotUC {
  static CommentSpotUC? _commentSpotUC;
  static CommentSpotUC get getInstance {
    _commentSpotUC ??=
        CommentSpotUC(commentRepositoryIMP: FirebaseCommentService.getInstance);
    return _commentSpotUC!;
  }

  final ICommentRepository commentRepositoryIMP;

  CommentSpotUC({required this.commentRepositoryIMP});

  Future<void> execulteAdd(Comment comentario) async {
    try {
      await commentRepositoryIMP.addComment(comentario);
    } catch (e) {
      throw Exception("Erro ao comentar: $e");
    }
  }

  Future<List<Comment>> execulte(String idPico) async {
    try {
      final listComment = await commentRepositoryIMP.getCommentsByPeak(idPico);
      return listComment;
    } catch (e) {
      return [];
    }
  }
}
