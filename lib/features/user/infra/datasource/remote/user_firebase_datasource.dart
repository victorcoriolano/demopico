import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/core/common/files_manager/enums/collections.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/datasources/firebase/crud_firebase.dart';
import 'package:demopico/features/external/datasources/firebase/firestore.dart';
import 'package:demopico/features/external/interfaces/i_crud_datasource.dart';
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

  final ICrudDataSource<FirebaseDTO, FirebaseFirestore> _dataSource;

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
      final query = await _dataSource.readAllWithFilter(field, value);
      final data = query.first;
      final dto = FirebaseDTO(id: data.id, data: data.data);
      return dto;
  }

  @override
  Future<bool> validateExistsData(String field, String value) async {
    try {
      debugPrint("VALIDANDO DADOS");
      return await _dataSource.existsDataWithField(field, value);
    } on Failure catch (known) {
      log("DTS - Failure: ${known.message}");
      rethrow;
    } catch (unknown, st) {
      log("DTS - Unknown: $unknown");
      throw UnknownFailure(unknownError: unknown, stackTrace: st);
    }
  }
  
  @override
  Future<void> update(FirebaseDTO user) async {
    await _dataSource.update(user); 
  }
  
  @override
  Future<List<FirebaseDTO>> getSuggestions(Set<String> exceptionsIDs) async {
    return await _dataSource.readMultiplesExcept("id", exceptionsIDs);
  }
  
  @override
  Stream<List<FirebaseDTO>> searchUsers(String query) {
    return _dataSource.watchWithFilter("name", query);
  }
  
  @override
  Future<List<FirebaseDTO>> getUsersExcept(String uid) {
    return _dataSource.readExcept("id", uid);
  }
  
  @override
  Future<List<FirebaseDTO>> findAll() {
    return _dataSource.readAll();
  }
  
  @override
  Future<List<FirebaseDTO>> getUsersByIds(List<String> ids) {
    return _dataSource.readMultiplesByIds(ids);
  }
}
