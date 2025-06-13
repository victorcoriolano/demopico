import 'package:demopico/features/mapa/data/dtos/firebase_dto.dart';

abstract class IPostDatasource {
  Future<FirebaseDTO> createPost(FirebaseDTO firebaseDTO);
  Future<List<FirebaseDTO>> getPosts();
  Future<FirebaseDTO> getPostbyID(String postId);
  Future<void> deletePost(String postId);
  Future<FirebaseDTO> updatePost(FirebaseDTO firebaseDTO);
}