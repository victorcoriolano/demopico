import 'package:demopico/core/common/collections/collections.dart';
import 'package:demopico/features/external/datasources/firebase/crud_firebase.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/datasources/firebase/firestore.dart';
import 'package:demopico/features/profile/domain/interfaces/i_message_datasource.dart';
import 'package:flutter/material.dart';


class MessageFirestoreDatasource implements IMessageDatasource<FirebaseDTO> {
  final CrudFirebase _boilerplate;

  static MessageFirestoreDatasource? _instance;
  static MessageFirestoreDatasource get instance {
    return _instance ??= MessageFirestoreDatasource(
      datasource: CrudFirebase(
        collection: Collections.chats, 
        firestore: Firestore.getInstance,
      ),
    );
  }

  MessageFirestoreDatasource({required CrudFirebase datasource}) : _boilerplate = datasource;

  @override
  Stream<List<FirebaseDTO>> getMessagesForChat(String idChat) {
    final snapshots = _boilerplate.dataSource
        .collection('chats')
        .doc(idChat)
        .collection('messages')
        .orderBy('dateTime', descending: true)
        .snapshots();

    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return FirebaseDTO(id: doc.id, data: doc.data());
      }).toList();
    });
  }

  @override
  Future<List<FirebaseDTO>> getChatForUser(String idUser) async {
    final querySnapshot = await _boilerplate.dataSource
        .collection('chats')
        .where('participantsIds', arrayContains: idUser)
        .get();
    debugPrint("Chats founded: ${querySnapshot.docs.length}");
    return querySnapshot.docs.map((doc) {
      return FirebaseDTO(id: doc.id, data: doc.data());
    }).toList();
  }

  @override
  Future<FirebaseDTO> sendMessage(String idChat, FirebaseDTO message) async {
    
    final newDoc = await _boilerplate.dataSource
        .collection('chats')
        .doc(idChat)
        .collection('messages')
        .add(message.data);

      await _boilerplate.dataSource
        .collection('chats')
        .doc(idChat)
        .update({
          'lastMessage': message.data["content"],
          'lastUpdate': message.data["dateTime"]
        });
      
      return message.copyWith(id: newDoc.id);
  }

  @override
  Future<void> readMessage(String idChat, FirebaseDTO message) async {
    await _boilerplate.dataSource
        .collection('chats')
        .doc(idChat)
        .collection('messages')
        .doc(message.id)
        .update({'isRead': true});
  }

  @override
  Future<FirebaseDTO> createChatForUser(FirebaseDTO chatDTO) async {
    final createdChat = await _boilerplate.create(chatDTO);
    return createdChat;
  }
}