import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/profile/domain/interfaces/i_message_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_notification_repository.dart';
import 'package:demopico/features/profile/domain/models/chat.dart';
import 'package:demopico/features/profile/domain/models/message.dart';
import 'package:demopico/features/profile/domain/models/notification.dart';
import 'package:demopico/features/profile/infra/repository/chat_repository.dart';
import 'package:demopico/features/profile/infra/repository/notification_repository_impl.dart';
import 'package:flutter/material.dart';

class SendMessageUc {
  final ImessageRepository _imessageRepository;
  final INotificationRepository _notificaitonRepo;

  SendMessageUc()
      : _imessageRepository = ChatRepository.instance,
        _notificaitonRepo = NotificationRepositoryImpl();

  Future<Message> execute(Chat chat, Message message) async {
    try {
      final newMessage =
          await _imessageRepository.sendMessage(chat.id, message);
      final notifications = chat.participantsIds
          .where((participant) => participant != message.infoUser.id)
          .map((user) => 
              NotificationItem(
              type: TypeNotification.newMessage,
              isRead: false,
              id: "",
              userId: user,
              message: "Nova mensagem do ${message.infoUser.name}",
              timestamp: DateTime.now()
          )).toList();
           

      await Future.wait(notifications.map((notification) =>
          _notificaitonRepo.createNotification(notification)));

      return newMessage;
    } on Failure catch (e) {
      debugPrint("UC FAILURE Erro ao enviar uma mensagem: $e");
      rethrow;
    }
  }
}
