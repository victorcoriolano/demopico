import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/profile/domain/interfaces/i_message_repository.dart';
import 'package:demopico/features/profile/domain/models/chat.dart';
import 'package:demopico/features/profile/domain/models/message.dart';
import 'package:flutter/material.dart';

class ChatRoomViewModel extends ChangeNotifier {
  final ImessageRepository _repository;

  ChatRoomViewModel({required ImessageRepository repository})
      : _repository = repository;
  Stream<List<Message>> listenMessagesForChat(Chat chat) {
    return _repository.getMessagesForChat(chat.id);
  }

  Future<bool> sendMessage(UserIdentification currentUserIdentification,
      String content, String idChat) async {
    try {
      final message = Message.initial(currentUserIdentification, content);
      await _repository.sendMessage(idChat, message);
      return true;
    } catch (e) {
      debugPrint("Erro ao enviar a mensagem: $e");
      return false;
    }
  }
}
