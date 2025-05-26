import 'package:demopico/features/mapa/data/dtos/firebase_dto.dart';
import 'package:demopico/features/mapa/domain/models/comment_model.dart';

class MapperDtoCommentmodel {
  static CommentModel fromDto(FirebaseDTO commentDto) {
    return CommentModel.fromJson(commentDto.data, commentDto.id);
  }

  static FirebaseDTO toDto(CommentModel commentModel) {
    return FirebaseDTO(
      id: commentModel.id,
      data: commentModel.toJson(),
    );
  }
}