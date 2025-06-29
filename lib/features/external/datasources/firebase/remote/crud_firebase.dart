import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/data/dtos/firebase_dto.dart';
import 'package:demopico/core/common/data/enums/collections.dart';
import 'package:demopico/features/external/datasources/firebase/remote/firestore.dart';
import 'package:demopico/features/external/interfaces/i_crud_datasource.dart';
import 'package:demopico/features/mapa/data/mappers/firebase_errors_mapper.dart';
import 'package:flutter/foundation.dart';

class CrudFirebase  implements ICrudDataSource<FirebaseDTO> {

  Collections collection;
  final FirebaseFirestore firestore;
  

  //singleton
  static CrudFirebase? _instance;
  static CrudFirebase get getInstance {
    _instance ??= CrudFirebase(collection: Collections.users, firestore: Firestore.getInstance);
    return _instance!;
  }

  //for testing
  CrudFirebase.test({
    required this.collection, 
    required FirebaseFirestore firestoreTest}): firestore = firestoreTest;

  //constructor
  CrudFirebase({required this.collection, required this.firestore});
    

  
  void setcollection(Collections collection) {
    _instance?.collection = collection;
  }


  @override
  Future<FirebaseDTO> create(FirebaseDTO model) async{
    try {
      await firestore.collection(collection.name).add(model.data);
      return model;
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    }
  }

  @override
  Future<FirebaseDTO> read(String id)async{
    try {
      final docRf = await firestore.collection(collection.name).doc(id).get();
      return FirebaseDTO(
        id: id, 
        data: docRf.data() as Map<String, dynamic>);
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    }
  }
  
  @override
  Future<FirebaseDTO> update(FirebaseDTO firebaseDto) async {
    try {
      await firestore.collection(collection.name).doc(firebaseDto.id).update(firebaseDto.data);
      return firebaseDto;
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    }
  }
  @override
  Future<void> delete(String id) async {
    try {
      await firestore.collection(collection.name).doc(id).delete();
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    }
  }
  
  @override
  Future<List<FirebaseDTO>>   readAll() async {
    try{
      final data = await firestore.collection(collection.name).get();
      return data.docs.map((doc) =>
         FirebaseDTO(
          id: doc.id,
          data: doc.data() 
        )).toList();
      
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    } catch (e, st) {
      debugPrint("${e.toString()} , ${st.toString()}");
      rethrow;
    }
  }

  
  @override
  Stream<List<FirebaseDTO>> watch() {
    try {
      return firestore.collection(collection.name).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => FirebaseDTO(
          id: doc.id,
          data: doc.data()
        )).toList()
      );
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    } catch (e, st) {
      debugPrint("${e.toString()}, ${st.toString()}");
      rethrow;
    }
  }
}