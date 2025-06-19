import 'package:demopico/core/common/data/dtos/firebase_dto.dart';
import 'package:demopico/core/common/data/enums/collections.dart';
import 'package:demopico/features/external/datasources/firebase/remote/crud_firebase.dart';
import 'package:demopico/features/profile/domain/interfaces/i_post_datasource.dart';

class FirebasePostDatasource implements IPostDatasource {


  static FirebasePostDatasource? _firebasePostDatasource;
  static FirebasePostDatasource get getInstance {
    _firebasePostDatasource ??= FirebasePostDatasource(
      crudFirebase: CrudFirebase.getInstance..setTable(Collections.posts)
    );
    return _firebasePostDatasource!;
  }


  final CrudFirebase crudFirebase;
  
  
  FirebasePostDatasource({required this.crudFirebase});

  @override
  Future<FirebaseDTO> createPost(FirebaseDTO firebaseDTO) async => 
      await crudFirebase.create(firebaseDTO);

  @override
  Future<void> deletePost(String postId) async {
    await crudFirebase.delete(postId);
  }

  @override
  Future<FirebaseDTO> getPostbyID(String postId) async {
    return await crudFirebase.read(postId);
  }

  @override
  Future<List<FirebaseDTO>> getPosts(String id) async {
    // TODO: implement getPosts
    throw UnimplementedError();
  }
  
  @override
  Future<FirebaseDTO> updatePost(FirebaseDTO firebaseDTO) async {
    return await crudFirebase.update(firebaseDTO);
  }
}