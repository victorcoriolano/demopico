import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/profile/domain/models/chat.dart';
import 'package:demopico/features/profile/domain/models/message.dart';

abstract class ImessageRepository {
    Stream<List<Message>> getMessagesForChat(String idChat);
    Future<List<Chat>> getChatForUser(String idUser);
    Future<Chat> createChat(UserIdentification currentUser, UserIdentification otherUser);
    Future<Message> sendMessage(String idChat, Message message);
    Future<void> readMessage(String idChat, Message message);
}