import 'package:demopico/features/profile/domain/interfaces/i_post_repository.dart';
import 'package:demopico/features/profile/domain/models/post.dart';
import 'package:demopico/features/profile/infra/repository/post_repository.dart';

class UpdatePostUc {
  final IPostRepository _postRepository;

  UpdatePostUc({required IPostRepository repository}): _postRepository = repository;

  static UpdatePostUc? _instance;
  static UpdatePostUc get instance => 
    _instance ??= UpdatePostUc(
      repository: PostRepository.getInstance
    );

  Future<Post> execute(Post post) async {
    return await _postRepository.updatePost(post);
  } 
}