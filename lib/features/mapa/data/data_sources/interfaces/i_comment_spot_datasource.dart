import 'package:demopico/features/mapa/data/dtos/comment_spot_firebase_dto.dart';

abstract class ICommentSpotDataSource {
  Future<CommenSpotFirebaseDto> create(CommenSpotFirebaseDto newComment);
  Future<void> delete(String id);
  Future<List<CommenSpotFirebaseDto>> getBySpotId(String spotId);
  Future<void> update(CommenSpotFirebaseDto commentDto);
}