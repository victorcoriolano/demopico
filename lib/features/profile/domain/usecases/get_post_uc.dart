import 'package:demopico/features/profile/domain/models/post.dart';
import 'package:demopico/features/profile/infra/repository/post_repository.dart';
import 'package:flutter/foundation.dart';

class GetPostUc {
  final PostRepository _postRepository;

  GetPostUc({required PostRepository postRepository}): _postRepository = postRepository;

  static GetPostUc? _instance;
  static GetPostUc get instance => _instance ?? GetPostUc(postRepository: PostRepository.getInstance);

  Future<List<Post>> execute(String userId) async {
    debugPrint('GetPostUc: Execute called');
    return await _postRepository.getPosts(userId);
  }
}
