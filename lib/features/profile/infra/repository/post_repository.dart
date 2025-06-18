import 'package:demopico/core/common/data/mappers/firebase_dto_mapper.dart';
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

  final _mapper = FirebaseDtoMapper(
    fromJson: (data, id) => Post.fromJson(data, id),
    toMap: (post) => post.toJson(),
    getId: (post) => post.id,
  );


  @override
  Future<Post> createPost(Post post) async {
    
    final dto = await postDatasource.createPost(_mapper.toDTO(post));
    return _mapper.fromDto(dto);

  }

  @override
  Future<void> deletePost(String postId) async =>
    await postDatasource.deletePost(postId);
    
  

  @override
  Future<Post> getPostbyID(String postId) async {
    final dto = await postDatasource.getPostbyID(postId);
    return _mapper.fromDto(dto);
  }

  @override
  Future<List<Post>> getPosts(String uid) async {
    final listDto = await  postDatasource.getPosts();
    return listDto.map((dto) => _mapper.fromDto(dto)).toList();
  }

  @override
  Future<Post> updatePost(Post post) async {
    final dto = await postDatasource.updatePost(_mapper.toDTO(post));
    return _mapper.fromDto(dto);
  }


}