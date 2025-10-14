import 'package:demopico/features/profile/domain/models/chat.dart';
import 'package:demopico/features/profile/domain/models/message.dart';

abstract class ImessageRepository {
    Stream<List<Message>> getMessagesForChat(String idChat);
    Future<List<Chat>> getChatForUser(String idUser);
    Future<void> sendMessage(String idChat, Message message);
    Future<void> readMessage(String idChat, Message message);
}