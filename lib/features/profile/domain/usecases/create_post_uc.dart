import 'package:demopico/features/profile/domain/models/post.dart';
import 'package:demopico/features/profile/infra/repository/post_repository.dart';

class CreatePostUc {
 final PostRepository _postRepository;

 CreatePostUc(this._postRepository);

 Future<void> execute(Post newPost) async {
    await _postRepository.createPost(newPost);
  }
}