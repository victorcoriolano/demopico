import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/data/dtos/firebase_dto.dart';
import 'package:demopico/features/profile/domain/interfaces/i_post_datasource.dart';

class FirebasePostDatasource implements IPostDatasource {
  final FirebaseFirestore _firestore;

  FirebasePostDatasource(this._firestore);

  static FirebasePostDatasource? _firebasePostDatasource;
  static FirebasePostDatasource get getInstance {
    _firebasePostDatasource ??= FirebasePostDatasource(
      FirebaseFirestore.instance,
    );
    return _firebasePostDatasource!;
  }

  final String collectionName = "posts";

  @override
  Future<FirebaseDTO> createPost(FirebaseDTO firebaseDTO) async{
    try{
      final docRef = await _firestore.collection(collectionName).add(firebaseDTO.data);
      return firebaseDTO.copyWith(id: docRef.id);
    }catch(e){
      throw Exception("Erro ao criar o post: $e");
    }
  }

  @override
  Future<void> deletePost(String postId) async {
    try{
      await _firestore.collection(collectionName).doc(postId).delete();
    }catch(e){
      throw Exception("Erro ao deletar o post: $e");
    }
  }

  @override
  Future<FirebaseDTO> getPostbyID(String postId) async {
    final docRef = await _firestore.collection(collectionName).doc(postId).get();
    return FirebaseDTO(
      id: docRef.id,
      data: docRef.data() as Map<String, dynamic>,
    );
  }

  @override
  Future<List<FirebaseDTO>> getPosts() {
    try{
      final snapshot = _firestore.collection(collectionName).get();
      return snapshot.then((value) => value.docs.map((e) => FirebaseDTO(
        id: e.id,
        data: e.data(),
      )).toList());
    }catch(e){
      throw Exception("Erro ao buscar os posts: $e");
    }
  }
  
  @override
  Future<FirebaseDTO> updatePost(FirebaseDTO firebaseDTO) async {
    try{
      await _firestore.collection(collectionName).doc(firebaseDTO.id).update(firebaseDTO.data);
      return firebaseDTO;
    }catch(e){
      throw Exception("Erro ao atualizar o post: $e");
    }
  }
}