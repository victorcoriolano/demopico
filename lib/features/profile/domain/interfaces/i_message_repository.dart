import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/profile/domain/models/chat.dart';
import 'package:demopico/features/profile/domain/models/message.dart';

abstract class ImessageRepository {
    Stream<List<Message>> watchMessagesForChat(String idChat);
    Future<List<Chat>> getChatForUser(UserIdentification currentUser);
    Future<Chat> createChat(Chat chat, UserIdentification currentUser );
    Future<Message> sendMessage(String idChat, Message message);
    Future<void> readMessage(String idChat, Message message);
}