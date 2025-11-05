import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/profile/domain/models/message.dart';

sealed class Chat {
  String get id;
  String? get photoUrl;
  String get nameChat;
  DateTime? get lastUpdate;
  Message get lastReadMessage;
  String get lastMessage;
  List<String> get participantsIds;
}

class Conversation extends Chat {
  @override
  final String id;
  @override
  final DateTime? lastUpdate;
  @override
  final Message lastReadMessage;
  @override
  final String lastMessage;
  @override
  final List<String> participantsIds;
  
  final List<UserIdentification> _participantsData;
  final String _currentUserId;

  Conversation({
    required this.lastUpdate,
    required this.id,
    required this.lastMessage,
    required this.participantsIds,
    required this.lastReadMessage,
    required List<UserIdentification> participantsData,
    required String currentUserId,
  }) : _participantsData = participantsData,
        _currentUserId = currentUserId;

  factory Conversation.initFromUsers(UserIdentification currentUser, UserIdentification otherUser){
    return Conversation(
      currentUserId: currentUser.id,
      participantsData: [currentUser, otherUser],
      lastUpdate: null,
      lastMessage: "Inicie uma conversa com ${otherUser.name}", 
      participantsIds: List<String>.from([currentUser.id, otherUser.id]), 
      id: "", // sera inserido no bd
      lastReadMessage: Message.initial(currentUser, "content"),
    );    
  }

  UserIdentification get _otherUser {
    return _participantsData.firstWhere(
      (user) => user.id != _currentUserId,
      orElse: () => _participantsData.first, // Fallback
    );
  }

  @override
  String? get photoUrl => _otherUser.profilePictureUrl;

  @override
  String get nameChat => _otherUser.name;

  Map<String, dynamic> toMap() {
    return {
      'chatType': 'conversation', // ATRIBUTO DISCRIMINADOR PARA AJUDAR NO MAPEAMENTO DO DATASOURCE
      'lastUpdate': lastUpdate?.toIso8601String(),
      'lastMessage': lastMessage,
      'participantsIds': participantsIds,
      'participantsData': _participantsData.map((user) => user.toJson()).toList(), 
      // 'nameChat' e 'photo' não é armazenado, pois é derivado (SÃO DADOS DO OUTRO USUÁRIO)
      'lastReadMessage': lastReadMessage.toJson(),
    };
  }

  factory Conversation.fromMap(Map<String, dynamic> map, String id, UserIdentification currentUser) {
    try {
      final participantsList = (map['participantsData'] as List)
          .map((user) => UserIdentification.fromJson(user as Map<String, dynamic>))
          .toList();
      
      

      return Conversation(
        participantsData: participantsList,
        currentUserId: currentUser.id,
        id: id,
        lastUpdate: map["lastUpdate"] != null ? DateTime.tryParse(map["lastUpdate"]) : null,
        lastMessage: map["lastMessage"] ?? '',
        participantsIds: List.from(map['participantsIds'] ?? ''),
        lastReadMessage: Message.fromMap(map['lastReadMessage']), // Assumindo que Message tem fromMap()
      );
    } catch (e) {
      throw Exception("Erro ao mapear Conversation: $e");
    }
  }
}

class GroupChat extends Chat{
  @override
  final String id;
  @override
  final DateTime? lastUpdate;
  @override
  final Message lastReadMessage;
  @override
  final String lastMessage;
  @override
  final String nameChat;
  @override
  final List<String> participantsIds;
  @override
  final String? photoUrl;


  GroupChat({
    required this.lastReadMessage,
    required this.lastUpdate,
    required this.id,
    required this.lastMessage,
    required this.nameChat,
    required this.participantsIds,
    required this.photoUrl,
  });

  factory GroupChat.initial(List<UserIdentification> members, String nameChat, String photoUrl,){
    return GroupChat(
      lastReadMessage: Message.initialChat(), 
      lastUpdate: DateTime.now(), 
      id: "", 
      lastMessage: "Envie a primeira mensagem", 
      nameChat: nameChat, 
      participantsIds: members.map((u) => u.id).toList(), photoUrl: photoUrl
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'chatType': 'group', // <-- O DISCRIMINADOR
      'nameChat': nameChat, // Nome é armazenado
      'photoUrl': photoUrl, // Foto é armazenada
      'lastUpdate': lastUpdate?.toIso8601String(),
      'lastMessage': lastMessage,
      'participantsIds': participantsIds,
      'lastReadMessage': lastReadMessage.toJson(),
    };
  }

  // Factory para construir o modelo a partir de um Map
  factory GroupChat.fromMap(Map<String, dynamic> map, String id) {
    try {
      return GroupChat(
        id: id,
        nameChat: map['nameChat'],
        photoUrl: map['photoUrl'],
        lastUpdate: map["lastUpdate"] != null ? DateTime.tryParse(map["lastUpdate"]) : null,
        lastMessage: map["lastMessage"] ?? '',
        participantsIds: List.from(map['participants']),
        lastReadMessage: Message.fromMap(map['lastReadMessage']),
      );
    } catch (e) {
      throw Exception("Erro ao mapear GroupChat: $e");
    }
  }
}