import 'package:demopico/features/profile/domain/models/post.dart';
import 'package:demopico/features/profile/infra/repository/post_repository.dart';

class CreatePostUc {
 final PostRepository _postRepository;

 static CreatePostUc? _instance;
 static CreatePostUc get instace => 
 _instance ?? CreatePostUc(postRepository: PostRepository.getInstance); 

 CreatePostUc({required PostRepository postRepository}) : _postRepository = postRepository;

 Future<void> execute(Post newPost) async {
    await _postRepository.createPost(newPost);
  }
}