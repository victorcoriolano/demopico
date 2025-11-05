import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/profile/domain/models/chat.dart';
import 'package:demopico/features/profile/domain/models/message.dart';
import 'package:demopico/features/profile/domain/usecases/send_message_uc.dart';
import 'package:demopico/features/profile/domain/usecases/watch_message_uc.dart';
import 'package:flutter/material.dart';

class ChatRoomViewModel extends ChangeNotifier {
  final WatchMessageUc _watchMessageUc;
  final SendMessageUc _sendMessageUc;

  ChatRoomViewModel()
      : _sendMessageUc = SendMessageUc(), _watchMessageUc = WatchMessageUc() ;

      
  Stream<List<Message>> listenMessagesForChat(Chat chat) {
    return _watchMessageUc.execute(chat);
  }

  Future<bool> sendMessage(UserIdentification currentUserIdentification,
      String content, Chat chat) async {
    try {
      final message = Message.initial(currentUserIdentification, content);
      await _sendMessageUc.execute(chat, message);
      return true;
    } catch (e) {
      debugPrint("Erro ao enviar a mensagem: $e");
      return false;
    }
  }
}
