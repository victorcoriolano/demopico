import 'package:demopico/features/mapa/domain/entities/comment.dart';

abstract class ICommentRepository {

  Future<void> addComment(Comment comment) ;
  Future<List<Comment>> getCommentsByPeak(String peakId);

}
