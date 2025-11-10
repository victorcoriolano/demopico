import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/core/common/collections/collections.dart';
import 'package:demopico/features/external/datasources/firebase/crud_firebase.dart';
import 'package:demopico/features/profile/domain/interfaces/i_post_datasource.dart';
import 'package:flutter/foundation.dart';

class FirebasePostDatasource implements IPostDatasource {


  static FirebasePostDatasource? _firebasePostDatasource;
  static FirebasePostDatasource get getInstance {
    _firebasePostDatasource ??= FirebasePostDatasource(
      crudFirebase: CrudFirebase(collection: Collections.posts, firestore: FirebaseFirestore.instance)
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
    debugPrint('FirebasePostDatasource: Fetching post with id $postId');
    return await crudFirebase.read(postId);
  }

  @override
  Future<List<FirebaseDTO>> getPostsByUserId(String id) async {
    final query = await crudFirebase.dataSource
      .collection(crudFirebase.collection.name)
      .where("userId", isEqualTo: id)
      .get();

    return query.docs.map(
      (doc) => FirebaseDTO(
        id: doc.id,
        data: doc.data()
      )
    ).toList();
  }
  
  @override
  Future<FirebaseDTO> updatePost(FirebaseDTO firebaseDTO) async {
    return await crudFirebase.update(firebaseDTO);
  }
  
  @override
  Future<List<FirebaseDTO>> getPostsByCollectiveId(String idCollective) async {
    final query = await crudFirebase.dataSource
      .collection(crudFirebase.collection.name)
      .where("profileRelated", isEqualTo: idCollective)
      .get();

    return query.docs.map(
      (doc) => FirebaseDTO(
        id: doc.id,
        data: doc.data()
      )
    ).toList();
  }
}