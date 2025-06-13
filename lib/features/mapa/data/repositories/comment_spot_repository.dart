import 'package:demopico/features/mapa/data/data_sources/interfaces/i_comment_spot_datasource.dart';
import 'package:demopico/features/mapa/data/data_sources/remote/firebase_comment_service.dart';
import 'package:demopico/features/mapa/data/mappers/mapper_dto_commentmodel.dart';
import 'package:demopico/features/mapa/domain/entities/comment.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_comment_repository.dart';
import 'package:demopico/features/mapa/domain/models/comment_model.dart';

class CommentSpotRepositoryImpl implements ICommentRepository {
  static CommentSpotRepositoryImpl? _commentSpotRepositoryImpl;
  static CommentSpotRepositoryImpl get getInstance {
    _commentSpotRepositoryImpl ??= CommentSpotRepositoryImpl(FirebaseCommentRemoteDataSource.getInstance);
    return _commentSpotRepositoryImpl!;
  }
  final ICommentSpotDataSource datasource;

  CommentSpotRepositoryImpl(this.datasource);

  @override
  Future<CommentModel> addComment(Comment comment) async {
    final commentDto = MapperDtoCommentmodel.toDto(CommentModel.fromEntity(comment));
    return MapperDtoCommentmodel.fromDto(await datasource.create(commentDto));
  }

  @override
  Future<void> deleteComment(String commentId) async  {
    await datasource.delete(commentId);
  }

  @override
  Future<List<CommentModel>> getCommentsByPeak(String peakId) async{
    final commentsDto = await datasource.getBySpotId(peakId);
    final comments = commentsDto.map((e) => MapperDtoCommentmodel.fromDto(e)).toList();
    return comments;
  }

  @override
  Future<CommentModel> updateComment(CommentModel comment) async{
    final commentDto = MapperDtoCommentmodel.toDto(comment);
    await datasource.update(commentDto);
    return comment;
  }

}