
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/profile/domain/interfaces/i_message_datasource.dart';
import 'package:demopico/features/profile/domain/interfaces/i_message_repository.dart';
import 'package:demopico/features/profile/domain/models/chat.dart';
import 'package:demopico/features/profile/domain/models/message.dart';
import 'package:demopico/features/profile/infra/datasource/firebase_message_datasourece.dart';
import 'package:flutter/widgets.dart';

class ChatRepository implements ImessageRepository {
  final IMessageDatasource<FirebaseDTO> _datasource;


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
  Stream<List<Message>> watchMessagesForChat(String idChat) {
    
    final dtoStream = _datasource.watchMessagesForChat(idChat);

    
    return dtoStream.map((dtoList) {
      return dtoList.map((dto) => messageMapper.toModel(dto)).toList();
    });
  }

  @override
  Future<List<Chat>> getChatForUser(UserIdentification currentUser) async {
    
    final dtoList = await _datasource.getChatForUser(currentUser.id);
    
    return dtoList.map((dto) { 
      final mapper = createChatMapper(currentUser);
      return mapper.toModel(dto);}).toList();
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
    final chatDTO = FirebaseDTO(
      id: "", 
      data: chat.toMap());
    final createdChat = await _datasource.createChat(chatDTO);
    debugPrint("Chat criado: $createdChat");
    return chat;
  }
  
  @override
  Future<Chat> createGroupChat(List<UserIdentification> members) {
    // TODO: implement createGroupChat
    throw UnimplementedError();
  }
}