import 'package:demopico/features/profile/domain/models/post.dart';

abstract class IPostRepository {
  Future<Post> createPost(Post post);
  Future<List<Post>> getPosts(String uid);
  Future<Post> getPostbyID(String postId);
  Future<void> deletePost(String postId);
  Future<Post> updatePost(Post post);
}