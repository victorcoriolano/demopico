import 'package:demopico/core/common/data/interfaces/datasource/mappers/i_mapper_firebase_dto.dart';
import 'package:demopico/features/mapa/data/dtos/firebase_dto.dart';
import 'package:demopico/features/mapa/domain/models/comment_model.dart';

class MapperDtoCommentmodel implements IMapperFirebaseDto<CommentModel> {
  
  @override
   CommentModel fromDto(FirebaseDTO commentDto) {
    return CommentModel.fromJson(commentDto.data, commentDto.id);
  }
  
  @override
  FirebaseDTO toDTO(CommentModel model) {
     return FirebaseDTO(
      id: model.id,
      data: model.toJson(),
    );
  }
}