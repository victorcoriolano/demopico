import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';

abstract class ICommentSpotDataSource {
  Future<FirebaseDTO> create(FirebaseDTO newComment);
  Future<void> delete(String id);
  Future<List<FirebaseDTO>> getBySpotId(String spotId);
  Future<void> update(FirebaseDTO commentDto);
}