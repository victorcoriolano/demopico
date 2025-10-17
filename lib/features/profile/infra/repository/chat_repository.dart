
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/profile/domain/interfaces/i_message_datasource.dart';
import 'package:demopico/features/profile/domain/interfaces/i_message_repository.dart';
import 'package:demopico/features/profile/domain/models/chat.dart';
import 'package:demopico/features/profile/domain/models/message.dart';
import 'package:demopico/features/profile/infra/datasource/firebase_message_datasourece.dart';

class ChatRepository implements ImessageRepository {
  final IMessageDatasource<FirebaseDTO> _datasource;
final chatConversationMapper = FirebaseDtoMapper<Conversation>(
  fromJson: (map, id) => Conversation.fromMap(map, id),
  toMap: (chat) => chat.toJson(),
  getId: (chat) => chat.id,
);

final chatGroupMapper = FirebaseDtoMapper<GroupChat>(
  fromJson: (map, id) => GroupChat.fromJson(map, id),
  toMap: (chat) => chat.toJson(),
  getId: (chat) => chat.id,
);

final messageMapper = FirebaseDtoMapper<Message>(
  fromJson: (map, id) {
    map["id"] = id; 
    return Message.fromMap(map);}, 
  toMap: (message) => message.toJson(),
  getId: (message) => message.id, 
);

  ChatRepository({
    required IMessageDatasource<FirebaseDTO> datasource,
  })  : _datasource = datasource;

    static ChatRepository? _instance;


  static ChatRepository get instance =>
    _instance ??= ChatRepository(
      datasource: MessageFirestoreDatasource.instance
    );

  @override
  Stream<List<Message>> getMessagesForChat(String idChat) {
    
    final dtoStream = _datasource.getMessagesForChat(idChat);

    
    return dtoStream.map((dtoList) {
      return dtoList.map((dto) => messageMapper.toModel(dto)).toList();
    });
  }

  @override
  Future<List<Chat>> getChatForUser(String idUser) async {
    
    final dtoList = await _datasource.getChatForUser(idUser);
    
    return dtoList.map((dto) => chatConversationMapper.toModel(dto)).toList();
  }

  @override
  Future<Message> sendMessage(String idChat, Message message) async {
    final messageDto = messageMapper.toDTO(message);

    final sentMessage = await _datasource.sendMessage(idChat, messageDto);
    return messageMapper.toModel(sentMessage);
  }

  @override
  Future<void> readMessage(String idChat, Message message) async {
    final messageDto = messageMapper.toDTO(message);
    await _datasource.readMessage(idChat, messageDto);
  }

  @override
  Future<Chat> createChat(UserIdentification currentUser, UserIdentification otherUser) async {
    final chat = Conversation.initFromUsers(currentUser, otherUser);
    final chatDTO = chatConversationMapper.toDTO(chat);
    final createdChat = await _datasource.createChatForUser(chatDTO);
    return chatConversationMapper.toModel(createdChat);
  }
}