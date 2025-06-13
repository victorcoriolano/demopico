import 'package:demopico/features/profile/domain/interfaces/i_post_datasource.dart';
import 'package:demopico/features/profile/domain/interfaces/i_post_repository.dart';
import 'package:demopico/features/profile/domain/models/post.dart';
import 'package:demopico/features/profile/infra/datasource/firebase_post_datasource.dart';

class PostRepository implements IPostRepository {
  final IPostDatasource postDatasource;

  PostRepository({required this.postDatasource});

  static PostRepository? _postRepository;
  static PostRepository get getInstance {
    _postRepository ??= PostRepository(postDatasource: FirebasePostDatasource.getInstance);
    return _postRepository!;
  }

  @override
  Future<Post> createPost(Post post) {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Future<void> deletePost(String postId) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Post> getPostbyID(String postId) {
    // TODO: implement getPostbyID
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> getPosts(String uid) {
    // TODO: implement getPosts
    throw UnimplementedError();
  }

  @override
  Future<Post> updatePost(Post post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }


}