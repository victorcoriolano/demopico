import 'package:demopico/features/mapa/data/dtos/comment_spot_firebase_dto.dart';
import 'package:demopico/features/mapa/domain/models/comment_model.dart';

class MapperDtoCommentmodel {
  static CommentModel fromDto(CommenSpotFirebaseDto commentDto) {
    return CommentModel.fromJson(commentDto.data, commentDto.id);
  }

  static CommenSpotFirebaseDto toDto(CommentModel commentModel) {
    return CommenSpotFirebaseDto(
      id: commentModel.id,
      data: commentModel.toJson(),
    );
  }
}