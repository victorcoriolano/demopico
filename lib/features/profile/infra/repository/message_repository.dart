
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/external/datasources/firebase/firestore.dart';
import 'package:demopico/features/profile/domain/interfaces/i_message_datasource.dart';
import 'package:demopico/features/profile/domain/interfaces/i_message_repository.dart';
import 'package:demopico/features/profile/domain/models/chat.dart';
import 'package:demopico/features/profile/domain/models/message.dart';
import 'package:demopico/features/profile/infra/datasource/firebase_message_datasourece.dart';

class MessageRepository implements ImessageRepository {
  final IMessageDatasource<FirebaseDTO> _datasource;
final chatConversationMapper = FirebaseDtoMapper<Conversation>(
  fromJson: (map, id) => Conversation.fromMap(map, id),
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

    static MessageRepository? _instance;


  static MessageRepository get instance =>
    _instance ??= MessageRepository(
      datasource: MessageFirestoreDatasource(firestore: Firestore.getInstance)
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