import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';

abstract class IPostDatasource {
  Future<FirebaseDTO> createPost(FirebaseDTO firebaseDTO);
  Future<List<FirebaseDTO>> getPostsByUserId(String idUser);
  Future<List<FirebaseDTO>> getPostsByCollectiveId(String idCollective);
  Future<FirebaseDTO> getPostbyID(String postId);
  Future<void> deletePost(String postId);
  Future<FirebaseDTO> updatePost(FirebaseDTO firebaseDTO);
}