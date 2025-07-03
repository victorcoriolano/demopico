import 'package:demopico/features/profile/domain/models/post.dart';
import 'package:demopico/features/profile/infra/repository/post_repository.dart';

class CreatePostUc {
 final PostRepository _postRepository;

 static CreatePostUc? _instance;
 static CreatePostUc get instace => 
 _instance ?? CreatePostUc(postRepository: PostRepository.getInstance); 

 CreatePostUc({required PostRepository postRepository}) : _postRepository = postRepository;

  Future<Post> execute(Post newPost) async {
    final post = await _postRepository.createPost(newPost);
    return post;
  }
}