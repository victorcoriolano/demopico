import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/core/common/collections/collections.dart';
import 'package:demopico/features/external/datasources/firebase/firestore.dart';
import 'package:demopico/features/external/interfaces/i_crud_datasource.dart';
import 'package:demopico/core/common/mappers/firebase_errors_mapper.dart';
import 'package:flutter/foundation.dart';

class CrudFirebase implements ICrudDataSource<FirebaseDTO, FirebaseFirestore> {
  Collections collection;
  final FirebaseFirestore _firestore;

  //singleton
  static CrudFirebase? _instance;
  static CrudFirebase get getInstance {
    _instance ??= CrudFirebase(
        collection: Collections.users, firestore: Firestore.getInstance);
    return _instance!;
  }

  //constructor
  CrudFirebase({required this.collection, required FirebaseFirestore firestore})
      : _firestore = firestore;

  void setcollection(Collections collection) {
    _instance?.collection = collection;
  }

  @override
  Future<FirebaseDTO> create(FirebaseDTO dto) async{
    debugPrint("CRUD create - COLLECTION -> ${collection.name}");
    try {
      final docRef = await _firestore.collection(collection.name).add(dto.data);
      dto.setId = docRef.id;
      return dto;
    } on FirebaseException catch (e) {
      debugPrint("Data Source Error: $e");
      throw FirebaseErrorsMapper.map(e);
    }
  }

  @override
  Future<FirebaseDTO> createWithTwoCollections(FirebaseDTO dto) async {
    try {
      final docRef = await _firestore
          .collection(collection.name)
          .doc(dto.data['server'])
          .collection('mensagens')
          .add(dto.data);
      dto.setId = docRef.id;
      return dto;
    } on FirebaseException catch (e) {
      debugPrint("Data Source Error: $e");
      throw FirebaseErrorsMapper.map(e);
    } catch (unknownError, st){
      debugPrint("Erro não reconhecido");
      throw UnknownFailure(unknownError: unknownError,stackTrace: st);
    }
  }

  @override
  Future<FirebaseDTO> read(String id) async {
    try {
      final docRf = await _firestore
          .collection(collection.name)
          .doc(id)
          .get(GetOptions(source: Source.serverAndCache));
      if (!docRf.exists || docRf.data() == null) {
        throw DataNotFoundFailure(dataID: id);
      }
      return FirebaseDTO(id: id, data: docRf.data()!);
    } on FirebaseException catch (e) {
      debugPrint("Data Source Error: $e");
      throw FirebaseErrorsMapper.map(e);
    }
  }

  @override
  Future<FirebaseDTO> update(FirebaseDTO firebaseDto) async {
    debugPrint("CRUD update - COLLECTION -> ${collection.name}");
    try {
      await _firestore
          .collection(collection.name)
          .doc(firebaseDto.id)
          .update(firebaseDto.data);
      return firebaseDto;
    } on FirebaseException catch (e) {
      debugPrint("Data Source Error: $e");
      throw FirebaseErrorsMapper.map(e);
    }
  }

  @override
  Future<void> updateField(String id, String field, dynamic value) async {
    debugPrint("CRUD updateField - COLLECTION -> ${collection.name}");
    try {
      await _firestore
          .collection(collection.name)
          .doc(id)
          .update({field: value});
    } on FirebaseException catch (e) {
      debugPrint("Data Source Error: $e");
      throw FirebaseErrorsMapper.map(e);
    } on Exception catch (e) {
      debugPrint("Unknown Error: $e");
      throw UnknownFailure(originalException: e);
    } on Error catch (e) {
      debugPrint("Unknown Error: $e");
      throw UnknownFailure(unknownError: e);
    }
  }

  @override
  Future<void> delete(String id) async {
    debugPrint("CRUD delete - COLLECTION -> ${collection.name}");
    try {
      debugPrint("Called Delete");
      await _firestore
          .collection(collection.name)
          .doc(id)
          .delete()
          .then((_) => debugPrint('SUCCESSFULLY DELETED DOC'));
    } on FirebaseException catch (e) {
      debugPrint("Data Source Error: $e");
      throw FirebaseErrorsMapper.map(e);
    }
  }

  @override
  Future<List<FirebaseDTO>> readAll() async {
    debugPrint("CRUD READall - COLLECTION -> ${collection.name}");
    try {
      final data = await _firestore
          .collection(collection.name)
          .get(GetOptions(source: Source.serverAndCache));
      return data.docs
          .map((doc) => FirebaseDTO(id: doc.id, data: doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      debugPrint("Data Source Error: $e");
      throw FirebaseErrorsMapper.map(e);
    } catch (e, st) {
      debugPrint("${e.toString()} , ${st.toString()}");
      rethrow;
    }
  }

  @override
  Stream<List<FirebaseDTO>> watch() {
    debugPrint("CRUD watch - COLLECTION -> ${collection.name}");
    try {
      return _firestore.collection(collection.name).snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => FirebaseDTO(id: doc.id, data: doc.data()))
              .toList());
    } on FirebaseException catch (e) {
      debugPrint("Data Source Error: $e");
      throw FirebaseErrorsMapper.map(e);
    } catch (e, st) {
      debugPrint("${e.toString()}, ${st.toString()}");
      rethrow;
    }
  }

  @override
  Future<List<FirebaseDTO>> readAllWithFilter(
      String field, String value) async {
    debugPrint("CRUD READwithfilter - COLLECTION -> ${collection.name}");
    try {
      debugPrint("Lendo com filtro $field = $value");
      final query = await _firestore.collection(collection.name).where(field, isEqualTo: value).get();
      return query.docs.map((doc) {
        return FirebaseDTO(id: doc.id, data: doc.data());
      }).toList();
    } on FirebaseException catch (firebaseException) {
      debugPrint("Data Source Error: $firebaseException");
      throw FirebaseErrorsMapper.map(firebaseException);
    } on Exception catch (exception) {
      throw UnknownFailure(originalException: exception);
    } catch (unknown) {
      throw UnknownFailure(unknownError: unknown);
    }
  }

  @override
  Future<FirebaseDTO> setData(String id, FirebaseDTO data) async {
    debugPrint("CRUD setData - COLLECTION -> ${collection.name}");
    try {
      await _firestore.collection(collection.name).doc(id).set(data.data);
      return data.copyWith(id: id);
    } on FirebaseException catch (firebaseException) {
      debugPrint("Data Source Error: $firebaseException");
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
  Future<List<FirebaseDTO>> readWithTwoFilters(
      {required String field1,
      required String value1,
      required String field2,
      required String value2}) async {
    debugPrint("CRUD READ2filter - COLLECTION -> ${collection.name}");
    try {
      final query = await _firestore
          .collection(collection.name)
          .where(
            Filter.and(
              Filter(field1, isEqualTo: value1),
              Filter(field2, isEqualTo: value2) 
            )
          )
          .get();
      debugPrint("QUERY length: ${query.docs.length}");
      return query.docs.map((doc) {
        return FirebaseDTO(id: doc.id, data: doc.data());
      }).toList();
    } on FirebaseException catch (firebaseException) {
      debugPrint("Data Source Error: $firebaseException");
      throw FirebaseErrorsMapper.map(firebaseException);
    } on Exception catch (exception) {
      throw UnknownFailure(originalException: exception);
    } catch (unknown) {
      throw UnknownFailure(unknownError: unknown);
    }
  }

  @override
  Stream<FirebaseDTO> watchDoc(String id) {
    debugPrint("CRUD watchdoc - COLLECTION -> ${collection.name}");
    try {
      return _firestore
          .collection(collection.name)
          .doc(id)
          .snapshots()
          .map((doc) {
        if (!doc.exists || doc.data() == null) {
          throw DataNotFoundFailure();
        }
        return FirebaseDTO(id: doc.id, data: doc.data()!);
      });
    } on FirebaseException catch (firebaseException) {
      debugPrint("Data Source Error: $firebaseException");
      throw FirebaseErrorsMapper.map(firebaseException);
    } on Exception catch (exception) {
      throw UnknownFailure(originalException: exception);
    } catch (unknown) {
      throw UnknownFailure(unknownError: unknown);
    }
  }

  @override
  Stream<List<FirebaseDTO>> watchDocWithCollection(
      String docRef, String collectionPath) {
    try {
      return _firestore
          .collection(collection.name)
          .doc(docRef)
          .collection(collectionPath)
          .snapshots()
          .map((collection) {
        if (collection.docs.isEmpty) {
          throw DataNotFoundFailure();
        }
        return collection.docs.map((doc) {
          return FirebaseDTO(
            id: doc.id,
            data: doc.data(),
          );
        }).toList();
      });
    } on FirebaseException catch (firebaseException) {
      debugPrint("Data Source Error: $firebaseException");
      throw FirebaseErrorsMapper.map(firebaseException);
    } on Exception catch (exception) {
      throw UnknownFailure(originalException: exception);
    } catch (unknown) {
      throw UnknownFailure(unknownError: unknown);
    }
  }

  @override
  Future<bool> existsDataById(String id) async {
    debugPrint("CRUD existsData - COLLECTION -> ${collection.name}");
    try {
      final doc = await _firestore.collection(collection.name).doc(id).get();
      return doc.exists;
    } on FirebaseException catch (firebaseException) {
      debugPrint("Data Source Error: $firebaseException");
      throw FirebaseErrorsMapper.map(firebaseException);
    } on Exception catch (exception) {
      throw UnknownFailure(originalException: exception);
    } catch (unknown) {
      throw UnknownFailure(unknownError: unknown);
    }
  }

  @override
  Future<bool> existsDataWithField(String field, String value) async {
    debugPrint("CRUD existsdatawithfield - COLLECTION -> ${collection.name}");
    try {
      final query = await _firestore
          .collection(collection.name)
          .where(field, isEqualTo: value)
          .get();
      return query.docs.isNotEmpty;
    } on FirebaseException catch (firebaseException) {
      debugPrint("Data Source Error: $firebaseException");
      throw FirebaseErrorsMapper.map(firebaseException);
    } on Exception catch (exception) {
      throw UnknownFailure(originalException: exception);
    } catch (unknown) {
      throw UnknownFailure(unknownError: unknown);
    }
  }

  @override
  Stream<List<FirebaseDTO>> watchWithFilter(String field, String value) {
    debugPrint("CRUD watch with filter - COLLECTION -> ${collection.name}");
    return _firestore
        .collection(collection.name)
        .where(field, isEqualTo: value)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return FirebaseDTO(id: doc.id, data: doc.data());
      }).toList();
    });
  }

  @override
  Future<List<FirebaseDTO>> readExcept(String field, String value) async {
    debugPrint("CRUD read except - COLLECTION -> ${collection.name}");
    try {
      final query = await _firestore
          .collection(collection.name)
          .where(field, isNotEqualTo: value)
          .get();
      return query.docs.map((doc) {
        return FirebaseDTO(id: doc.id, data: doc.data());
      }).toList();
    } on FirebaseException catch (firebaseException) {
      debugPrint("Data Source Error: $firebaseException");
      throw FirebaseErrorsMapper.map(firebaseException);
    } on Exception catch (exception) {
      throw UnknownFailure(originalException: exception);
    } catch (unknown) {
      throw UnknownFailure(unknownError: unknown);
    }
  }

  @override
  Future<List<FirebaseDTO>> readMultiplesExcept(
      String field, Set<String> values) async {
    debugPrint("CRUD READmultipleexcept - COLLECTION -> ${collection.name}");
    try {
      final query = await _firestore
          .collection(collection.name)
          .where(field, whereNotIn: values.toList())
          .limit(7)
          .get();
      return query.docs.map((doc) {
        return FirebaseDTO(id: doc.id, data: doc.data());
      }).toList();
    } on FirebaseException catch (firebaseException) {
      debugPrint("Data Source Error: $firebaseException");
      throw FirebaseErrorsMapper.map(firebaseException);
    } on Exception catch (exception) {
      throw UnknownFailure(originalException: exception);
    } catch (unknown) {
      throw UnknownFailure(unknownError: unknown);
    }
  }

  @override
  Future<List<FirebaseDTO>> readMultiplesByIds(List<String> ids) {
    debugPrint("CRUD READMultiplesbyid - COLLECTION -> ${collection.name}");
    try {
      return _firestore
          .collection(collection.name)
          .where(FieldPath.documentId, whereIn: ids)
          .get()
          .then((snapshot) {
        return snapshot.docs.map((doc) {
          return FirebaseDTO(id: doc.id, data: doc.data());
        }).toList();
      });
    } on FirebaseException catch (firebaseException) {
      debugPrint("Data Source Error: $firebaseException");
      throw FirebaseErrorsMapper.map(firebaseException);
    } on Exception catch (exception) {
      throw UnknownFailure(originalException: exception);
    } catch (unknown) {
      throw UnknownFailure(unknownError: unknown);
    }
  }
  
  @override
  Future<List<FirebaseDTO>> readArrayContains({required String field, required String value}) {
     try {
      return _firestore
          .collection(collection.name)
          .where(field, arrayContains: value)
          .get()
          .then((snapshot) {
        return snapshot.docs.map((doc) {
          return FirebaseDTO(id: doc.id, data: doc.data());
        }).toList();
      });
    } on FirebaseException catch (firebaseException) {
      debugPrint("Data Source Error: $firebaseException");
      throw FirebaseErrorsMapper.map(firebaseException);
    } on Exception catch (exception) {
      throw UnknownFailure(originalException: exception);
    } catch (unknown) {
      throw UnknownFailure(unknownError: unknown);
    }
  }
}
