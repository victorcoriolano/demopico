import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/core/common/files_manager/enums/collections.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/datasources/firebase/crud_firebase.dart';
import 'package:demopico/features/external/datasources/firebase/firestore.dart';
import 'package:demopico/features/mapa/data/mappers/firebase_errors_mapper.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_service.dart';
import 'package:flutter/foundation.dart';

class UserFirebaseDataSource implements IUserDataSource<FirebaseDTO> {
  static UserFirebaseDataSource? _userFirebaseService;
  static UserFirebaseDataSource get getInstance {
    _userFirebaseService ??= UserFirebaseDataSource(
        datasource: CrudFirebase(
            collection: Collections.users, firestore: Firestore.getInstance));
    return _userFirebaseService!;
  }

  final CrudFirebase _dataSource; //TODO: ARRUMAR UM JEITO DE USAR A INTERFACE

  UserFirebaseDataSource({
    required CrudFirebase datasource,
  }) : _dataSource = datasource;

  @override
  Future<void> addUserDetails(FirebaseDTO newUser) async {
    try {
      await _dataSource.setData(newUser.id, newUser);
    } on FirebaseException catch (firebaseException) {
      throw FirebaseErrorsMapper.map(firebaseException);
    } on Exception catch (exception) {
      throw UnknownFailure(originalException: exception);
    } catch (unknown) {
      throw UnknownFailure(unknownError: unknown);
    }
  }

  @override
  Future<FirebaseDTO> getUserDetails(String uid) async {
    try {
      final dto = await _dataSource.read(uid);
      return dto;
    } on FirebaseException catch (firebaseException) {
      throw FirebaseErrorsMapper.map(firebaseException);
    } on Exception catch (exception) {
      throw UnknownFailure(originalException: exception);
    } catch (unknown) {
      throw UnknownFailure(unknownError: unknown);
    }
  }

  @override
  Future<String> getUserData(String id, String field) async {
    try {
      final dto = await _dataSource.read(id);
      return dto.data[field];
    } on FirebaseException catch (firebaseException) {
      throw FirebaseErrorsMapper.map(firebaseException);
    } on Exception catch (exception) {
      throw UnknownFailure(originalException: exception);
    } catch (unknown) {
      throw UnknownFailure(unknownError: unknown);
    }
  }

  @override
  Future<FirebaseDTO> getUserByField(String field, value) async {
    try {
      final query = await _dataSource.dataSource
          .collection("users")
          .where(field, isEqualTo: value)
          .get();
      final data = query.docs.first;
      final dto = FirebaseDTO(id: data.id, data: data.data());
      return dto;
    } on FirebaseException catch (firebaseException) {
      throw FirebaseErrorsMapper.map(firebaseException);
    } on Exception catch (exception) {
      throw UnknownFailure(originalException: exception);
    } catch (unknown) {
      throw UnknownFailure(unknownError: unknown);
    }
  }

  @override
  Future<bool> validateExistsData(String field, String value) async {
    try {
      debugPrint("VALIDANDO DADOS");
      final query = await _dataSource.dataSource
          .collection("users")
          .where(field, isEqualTo: value)
          .limit(2)
          .get();
      debugPrint("Lista atual: ${query.docs}");
      
      if (query.docs.isNotEmpty){
        debugPrint("Dados existem");
        return true;
      }
      // Dados não existem 
      return false;
    } on FirebaseException catch (firebaseException) {
      throw FirebaseErrorsMapper.map(firebaseException);
    } on Exception catch (exception) {
      throw UnknownFailure(originalException: exception);
    } catch (unknown) {
      throw UnknownFailure(unknownError: unknown);
    }
  }

}
