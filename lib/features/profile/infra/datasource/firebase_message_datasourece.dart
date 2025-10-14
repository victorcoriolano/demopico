import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/profile/domain/interfaces/i_message_datasource.dart';


class MessageFirestoreDatasource implements IMessageDatasource<FirebaseDTO> {
  final FirebaseFirestore _firestore;

  MessageFirestoreDatasource({required FirebaseFirestore firestore}) : _firestore = firestore;

  @override
  Stream<List<FirebaseDTO>> getMessagesForChat(String idChat) {
    // Escuta em tempo real a subcoleção 'messages' dentro de um chat específico
    final snapshots = _firestore
        .collection('chats')
        .doc(idChat)
        .collection('messages')
        .orderBy('dateTime', descending: true)
        .snapshots();

    // Transforma o Stream<QuerySnapshot> em um Stream<List<FirebaseDTO>>
    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return FirebaseDTO(id: doc.id, data: doc.data());
      }).toList();
    });
  }

  @override
  Future<List<FirebaseDTO>> getChatForUser(String idUser) async {
    // Busca por todos os chats onde o id do usuário está no array 'participants'
    final querySnapshot = await _firestore
        .collection('chats')
        .where('participants', arrayContains: idUser)
        .get();

    // Transforma o resultado da query em uma lista de FirebaseDTO
    return querySnapshot.docs.map((doc) {
      return FirebaseDTO(id: doc.id, data: doc.data());
    }).toList();
  }

  @override
  Future<void> sendMessage(String idChat, FirebaseDTO message) async {

    await _firestore
        .collection('chats')
        .doc(idChat)
        .collection('messages')
        .add(message.data);

      await _firestore
        .collection('chats')
        .doc(idChat)
        .update({'lastMessage': message.data});
  }

  @override
  Future<void> readMessage(String idChat, FirebaseDTO message) async {
    // Atualiza um documento de mensagem existente para marcar como lido
    await _firestore
        .collection('chats')
        .doc(idChat)
        .collection('messages')
        .doc(message.id)
        .update({'isRead': true});
  }
}