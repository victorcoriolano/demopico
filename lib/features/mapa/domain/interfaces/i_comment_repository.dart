import 'package:demopico/features/mapa/domain/entities/comment.dart';
import 'package:demopico/features/mapa/domain/models/comment_model.dart';

abstract class ICommentRepository {

  Future<CommentModel> addComment(Comment comment);
  Future<CommentModel> updateComment(CommentModel comment);
  Future<void> deleteComment(String commentId);
  Future<List<CommentModel>> getCommentsByPeak(String peakId);

}
