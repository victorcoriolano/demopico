
import 'package:demopico/core/common/data/mappers/i_mapper_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/mapa/data/data_sources/interfaces/i_comment_spot_datasource.dart';
import 'package:demopico/features/mapa/data/data_sources/remote/firebase_comment_service.dart';
import 'package:demopico/features/mapa/domain/entities/comment.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_comment_repository.dart';
import 'package:demopico/features/mapa/domain/models/comment_model.dart';



 /// representa o context do strategy
 

class CommentSpotRepositoryImpl implements ICommentRepository {
  static CommentSpotRepositoryImpl? _commentSpotRepositoryImpl;
  static CommentSpotRepositoryImpl get getInstance {
    _commentSpotRepositoryImpl ??= CommentSpotRepositoryImpl(FirebaseCommentRemoteDataSource.getInstance);
    return _commentSpotRepositoryImpl!;
  }
  final ICommentSpotDataSource datasource;

  CommentSpotRepositoryImpl(this.datasource);


  final IMapperDto _mapper = FirebaseDtoMapper<CommentModel>(
    fromJson: (data, id) => CommentModel.fromJson(data, id),
    toMap: (model) => model.toMap() , 
    getId: (model) => model.id,
  );



  @override
  Future<CommentModel> addComment(Comment comment) async {
    final commentDto = _mapper.toDTO(CommentModel.fromEntity(comment));
    return _mapper.toModel(await datasource.create(commentDto));
  }

  @override
  Future<void> deleteComment(String commentId) async  {
    await datasource.delete(commentId);
  }

  @override
  Future<List<CommentModel>> getCommentsByPeak(String peakId) async{
    final commentsDto = await datasource.getBySpotId(peakId);
    final comments = commentsDto.map((e) => _mapper.toModel(commentsDto)).toList();
    return comments as List<CommentModel>;
  }

  @override
  Future<CommentModel> updateComment(CommentModel comment) async{
    final commentDto = _mapper.toDTO(comment);
    await datasource.update(commentDto);
    return comment;
  }

}