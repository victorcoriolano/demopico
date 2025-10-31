import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/collections/collections.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/core/common/mappers/firebase_errors_mapper.dart';
import 'package:demopico/features/external/datasources/firebase/crud_firebase.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/datasources/firebase/firestore.dart';
import 'package:demopico/features/external/interfaces/i_crud_datasource.dart';
import 'package:demopico/features/profile/domain/interfaces/i_notification_datasource.dart';
import 'package:flutter/material.dart';

class FirebaseNotificationDatasource implements INotificationDatasource<FirebaseDTO> {
  
  final ICrudDataSource<FirebaseDTO, FirebaseFirestore> _crudDataSource;

  FirebaseNotificationDatasource() : _crudDataSource =CrudFirebase(collection: Collections.profiles, firestore: Firestore.getInstance);
  
  @override
  Future<void> createNotification(FirebaseDTO notification) async {
    try {
    debugPrint("Criando notificação no datasource - $notification idUser: ${notification.data['userId']}");
    final firestore = _crudDataSource.dataSource;
    await firestore.collection(Collections.profiles.name)
      .doc(notification.data['userId'])
      .collection('notifications')
      .add(notification.data);
    } on FirebaseException catch (e) {
      debugPrint("Data Source Error: $e");
      throw FirebaseErrorsMapper.map(e);
    } catch (unknownError, st){
      debugPrint("Erro não reconhecido");
      throw UnknownFailure(unknownError: unknownError,stackTrace: st);
    }
  }

  @override
  Stream<List<FirebaseDTO>> watchNotifications(String idUser) {
    // TODO: implement watchNotifications
    throw UnimplementedError();
  }
  
  @override
  Future<void> updateNotification(FirebaseDTO notification) {
    // TODO: implement updateNotification
    throw UnimplementedError();
  }
  
}