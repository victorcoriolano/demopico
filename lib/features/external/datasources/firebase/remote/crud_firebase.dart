import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/core/common/files_manager/enums/collections.dart';
import 'package:demopico/features/external/datasources/firebase/remote/firestore.dart';
import 'package:demopico/features/external/interfaces/i_crud_datasource.dart';
import 'package:demopico/features/mapa/data/mappers/firebase_errors_mapper.dart';
import 'package:flutter/foundation.dart';

class CrudFirebase implements ICrudDataSource<FirebaseDTO, FirebaseFirestore> {

  Collections collection;
  final FirebaseFirestore _firestore;
  

  //singleton
  static CrudFirebase? _instance;
  static CrudFirebase get getInstance {
    _instance ??= CrudFirebase(collection: Collections.users, firestore: Firestore.getInstance);
    return _instance!;
  }


  //constructor
  CrudFirebase({required this.collection, required FirebaseFirestore firestore}): _firestore = firestore;
    

  
  void setcollection(Collections collection) {
    _instance?.collection = collection;
  }


  @override
  Future<FirebaseDTO> create(FirebaseDTO model) async{
    try {
      await _firestore.collection(collection.name).add(model.data);
      return model;
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    }
  }

  @override
  Future<FirebaseDTO> read(String id)async{
    try {
      final docRf = await _firestore.collection(collection.name).doc(id).get(
        GetOptions(source: Source.serverAndCache)
      );
      if (!docRf.exists || docRf.data() == null) throw DataNotFoundFailure(); 
      return FirebaseDTO(
        id: id, 
        data: docRf.data()!);
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    }
  }
  
  @override
  Future<FirebaseDTO> update(FirebaseDTO firebaseDto) async {
    try {
      await _firestore.collection(collection.name).doc(firebaseDto.id).update(firebaseDto.data);
      return firebaseDto;
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    }
  }
  @override
  Future<void> delete(String id) async {
    try {
      debugPrint("Called Delete");
      await _firestore.collection(collection.name).doc(id).delete(). then((_) => debugPrint('SUCCESSFULLY DELETED DOC'));
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    }
  }
  
  @override
  Future<List<FirebaseDTO>>   readAll() async {
    try{
      final data = await _firestore.collection(collection.name).get(
        GetOptions(source: Source.serverAndCache)
      );
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
      return _firestore.collection(collection.name).snapshots().map((snapshot) =>
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
  
  @override
  Future<List<FirebaseDTO>> readAllWithFilter(String field, String value) async {
    try {
      final query = await _firestore.collection(collection.name).where(field, isEqualTo: value).get();
      return query.docs.map((doc) {
        return FirebaseDTO(id: doc.id, data: doc.data());
      }).toList();
    } on FirebaseException catch (firebaseException) {
      throw FirebaseErrorsMapper.map(firebaseException);
    } on Exception catch (exception) {
      throw UnknownFailure(originalException: exception);
    } catch (unknown) {
      throw UnknownFailure(unknownError: unknown);
    }
  }
  
  @override
  Future<FirebaseDTO> setData(String id, FirebaseDTO data) async {
    try {
      await _firestore.collection(collection.name).doc(id).set(data.data);
      return data.copyWith(id: id);
    } on FirebaseException catch (firebaseException) {
      throw FirebaseErrorsMapper.map(firebaseException);
    } on Exception catch (exception) {
      throw UnknownFailure(originalException: exception);
    } catch (unknown) {
      throw UnknownFailure(unknownError: unknown);
    }
  }
  
  @override
  FirebaseFirestore get dataSource => _firestore;
  
  @override
  Future<List<FirebaseDTO>> readWithFilter(String field, String value) async {
     try {
      final query = await _firestore.collection(collection.name).where(field, isEqualTo: value).get();
      debugPrint("QUERY length: ${query.docs.length}");
      return query.docs.map((doc) {
        return FirebaseDTO(id: doc.id, data: doc.data());
      }).toList();
    } on FirebaseException catch (firebaseException) {
      throw FirebaseErrorsMapper.map(firebaseException);
    } on Exception catch (exception) {
      throw UnknownFailure(originalException: exception);
    } catch (unknown) {
      throw UnknownFailure(unknownError: unknown);
    }
  }
  
  @override
  Stream<FirebaseDTO> watchDoc(String id) {
    try {
      return _firestore.collection(collection.name)
      .doc(id)
      .snapshots().map((doc) {
        if (!doc.exists || doc.data() == null){
          throw DataNotFoundFailure();
        }
        return FirebaseDTO(id: doc.id, data: doc.data()!);
      });
    } on FirebaseException catch (firebaseException) {
      throw FirebaseErrorsMapper.map(firebaseException);
    } on Exception catch (exception) {
      throw UnknownFailure(originalException: exception);
    } catch (unknown) {
      throw UnknownFailure(unknownError: unknown);
    }
  }
  
}
