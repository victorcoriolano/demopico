import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/profile/domain/interfaces/i_message_datasource.dart';
import 'package:demopico/features/profile/domain/interfaces/i_message_repository.dart';
import 'package:demopico/features/profile/domain/models/chat.dart';
import 'package:demopico/features/profile/domain/models/message.dart';
import 'package:demopico/features/profile/infra/datasource/firebase_message_datasourece.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_datasource_service.dart';
import 'package:demopico/features/user/infra/datasource/remote/user_firebase_datasource.dart';
import 'package:flutter/widgets.dart';

class ChatRepository implements ImessageRepository {
  final IMessageDatasource<FirebaseDTO> _datasource;
  final IUserDataSource<FirebaseDTO> _userDataSource;

  ChatRepository({
    required IMessageDatasource<FirebaseDTO> datasource,
  })  : _datasource = datasource,
        _userDataSource = UserFirebaseDataSource.getInstance;

  static ChatRepository? _instance;

  static ChatRepository get instance => _instance ??=
      ChatRepository(datasource: MessageFirestoreDatasource.instance);

  final messageMapper = FirebaseDtoMapper<Message>(
    fromJson: (map, id) {
      map["id"] = id;
      return Message.fromMap(map);
    },
    toMap: (message) => message.toJson(),
    getId: (message) => message.id,
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
    final FirebaseDTOMapperForChat chatMapper =
        FirebaseDTOMapperForChat(currentUser: currentUser);
    final dtoList = await _datasource.getChatForUser(currentUser.id);

    final completedModels = await Future.wait(dtoList.map((dto) async {
      final modelImcompleta = chatMapper.toModel(dto);
      final modelCompleta = await _completeChatData(modelImcompleta, currentUser);
      return modelCompleta;
    }).toList());

    return completedModels;
  }


  Future<Chat> _completeChatData(Chat chatIncompleto, UserIdentification currentUser) async {
    switch (chatIncompleto) {
      case Conversation _:
        final futures = await Future.wait([
          _fetchUser(chatIncompleto.participantsIds.firstWhere((id) => id != currentUser.id)),
          chatIncompleto.lastReadMessage != null ?  _fetchMessageById(
              chatIncompleto.id, chatIncompleto.lastReadMessage!.id) : Future.value(null),
        ]);
        debugPrint("$futures");
        debugPrint('anotherUserData: ${futures[0]}');
        debugPrint('lastReadMessage: ${futures[1]}');
        final UserIdentification otherUser = futures[0] as UserIdentification;
        final Message? lastReadMessage = futures[1] as Message?;
        debugPrint('otherUsername: ${otherUser.name}');
        debugPrint('otherUsername: ${otherUser.profilePictureUrl}');
        debugPrint('otherUsername: ${otherUser.id}');

        return chatIncompleto.copyWith(
          currentUser: currentUser,
          otherUser: otherUser,
          lastReadMessage: lastReadMessage,
          currentUserId: currentUser.id,
        );

      case GroupChat _:
        final futures = await Future.wait([
          _fetchMembers(chatIncompleto.participantsIds),
         chatIncompleto.lastReadMessage != null ? _fetchMessageById(chatIncompleto.id, chatIncompleto.lastMessage): Future.value(null),
        ]);
        debugPrint("$futures");
        debugPrint('membros: ${futures[0]}');
        debugPrint('lastReadMessage: ${futures[1]}');
        final List<UserIdentification> members =
            futures[0] as List<UserIdentification>;
        final Message? lastReadMessage = futures[1] as Message?;

        return chatIncompleto.copyWith(
          membersData: members,
          lastReadMessage: lastReadMessage,
        );
    }
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
  Future<Chat> createChat(Chat chat, UserIdentification currentUser) async {
    final chatDTOMapper = FirebaseDTOMapperForChat(currentUser: currentUser);
    final createdChat = await _datasource.createChat(chatDTOMapper.toDTO(chat));
    debugPrint("Chat criado: $createdChat");
    return chat;
  }

  Future<UserIdentification> _fetchUser(String id) async {
    final user =
        mapperUserModel.toModel(await _userDataSource.getUserDetails(id));
    return UserIdentification(
        id: id, name: user.name, profilePictureUrl: user.avatar);
  }

  Future<List<UserIdentification>> _fetchMembers(List<String> ids) async {
    final users = (await _userDataSource.getUsersByIds(ids))
        .map((u) => mapperUserModel.toModel(u))
        .toList();
    return users.map((user) {
      return UserIdentification(
          id: user.id, name: user.name, profilePictureUrl: user.avatar);
    }).toList();
  }

  Future<Message> _fetchMessageById(String idChat, String idMessage) async {
    return messageMapper
        .toModel(await _datasource.getMessageById(idChat, idMessage));
  }
  
  @override
  Future<void> addUserOnGroup(String idChat, List<String> idUser) async {
      return await _datasource.updateUsersOnGroup(idChat, idUser);
  }
  
  @override
  Future<void> removeUserOnGroup(String idChat, List<String> idUser) async {
    return await _datasource.updateUsersOnGroup(idChat, idUser);
  }
}
