
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/profile/domain/interfaces/i_message_datasource.dart';
import 'package:demopico/features/profile/domain/interfaces/i_message_repository.dart';
import 'package:demopico/features/profile/domain/models/chat.dart';
import 'package:demopico/features/profile/domain/models/message.dart';

class MessageRepository implements ImessageRepository {
  final IMessageDatasource<FirebaseDTO> _datasource;
final chatMapper = FirebaseDtoMapper<Chat>(
  
  fromJson: (map, id) => Chat.fromMap(map, id),
  
  toMap: (chat) => chat.toJson(),
  
  getId: (chat) => chat.id,
);

final messageMapper = FirebaseDtoMapper<Message>(
  
  fromJson: (map, id) => Message.fromMap(map, id), 
  toMap: (message) => message.toJson(),
  
  getId: (message) => message.id, 
);

  MessageRepository({
    required IMessageDatasource<FirebaseDTO> datasource,
  })  : _datasource = datasource;

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

    
    return dtoList.map((dto) => chatMapper.toModel(dto)).toList();
  }

  @override
  Future<void> sendMessage(String idChat, Message message) async {
    final messageDto = messageMapper.toDTO(message);

    await _datasource.sendMessage(idChat, messageDto);
  }

  @override
  Future<void> readMessage(String idChat, Message message) async {
    final messageDto = messageMapper.toDTO(message);


    await _datasource.readMessage(idChat, messageDto);
  }
}