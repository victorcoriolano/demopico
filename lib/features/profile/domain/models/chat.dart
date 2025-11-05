import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/profile/domain/models/message.dart';

sealed class Chat {
  String get id;
  String? get photoUrl;
  String get nameChat;
  DateTime? get lastUpdate;
  Message? get lastReadMessage;
  String get lastMessage;
  List<String> get participantsIds;

  
}

class Conversation extends Chat {
  @override
  final String id;
  @override
  final DateTime? lastUpdate;
  @override
  final Message? lastReadMessage;
  @override
  final String lastMessage;
  @override
  final List<String> participantsIds;
  
  final UserIdentification currentUser;
  final UserIdentification otherUser;
  final List<UserIdentification> _participantsData;
  final String _currentUserId;
  

  Conversation({
    required this.lastUpdate,
    required this.id,
    required this.lastMessage,
    required this.participantsIds,
    required this.lastReadMessage,
    required this.currentUser,
    required this.otherUser,
  }) : _participantsData = [currentUser, otherUser],
        _currentUserId = currentUser.id;

  factory Conversation.initFromUsers(UserIdentification currentUser, UserIdentification otherUser){
    return Conversation(
      currentUser: currentUser,
      otherUser:  otherUser,
      lastUpdate: null,
      lastMessage: "Inicie uma conversa", 
      participantsIds: List<String>.from([currentUser.id, otherUser.id]), 
      id: "", // sera inserido no bd
      lastReadMessage: null,
    );    
  }


  @override
  String? get photoUrl => otherUser.profilePictureUrl;

  @override
  String get nameChat => otherUser.name;

  Conversation copyWith(
    {
      String? id,
      DateTime? lastUpdate,
      Message? lastReadMessage,
      String? lastMessage,
      List<String>? participantsIds,
      UserIdentification? currentUser,
      UserIdentification? otherUser,
      String? currentUserId,
    }
  ){
    return Conversation(
      lastUpdate: lastUpdate ?? this.lastUpdate,
      id: id ?? this.id,
      lastMessage: lastMessage ?? this.lastMessage,
      participantsIds: participantsIds ?? this.participantsIds,
      lastReadMessage: lastReadMessage ?? this.lastReadMessage,
      currentUser: currentUser ?? this.currentUser,
      otherUser: otherUser ?? this.otherUser,); 
    }

}

class GroupChat extends Chat{
  @override
  final String id;
  @override
  final DateTime? lastUpdate;
  @override
  final Message? lastReadMessage;
  @override
  final String lastMessage;
  @override
  final String nameChat;
  @override
  final List<String> participantsIds;
  @override
  final String? photoUrl;

  final List<UserIdentification> membersData;



  GroupChat({
    required this.lastReadMessage,
    required this.lastUpdate,
    required this.id,
    required this.lastMessage,
    required this.nameChat,
    required this.participantsIds,
    required this.photoUrl,
    required this.membersData,
  });

  factory GroupChat.initial(List<UserIdentification> members, String nameChat, String photoUrl,){
    return GroupChat(
      lastReadMessage: null, 
      lastUpdate: DateTime.now(), 
      id: "", 
      lastMessage: "Envie a primeira mensagem", 
      nameChat: nameChat, 
      participantsIds: members.map((u) => u.id).toList(), photoUrl: photoUrl,
      membersData: members,
    );
  }

  GroupChat copyWith({
    String? lastMessage,
    DateTime? lastUpdate,
    String? id,
    Message? lastReadMessage,
    String? nameChat,
    List<String>? participantsIds,
    String? photoUrl,
    List<UserIdentification>? membersData,
  }){
    return GroupChat(
      id: id ?? this.id,
      lastMessage: lastMessage ?? this.lastMessage,
      lastReadMessage: lastReadMessage ?? this.lastReadMessage,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      nameChat: nameChat ?? this.nameChat,
      participantsIds: participantsIds ?? this.participantsIds,
      photoUrl: photoUrl ?? this.photoUrl,
      membersData: membersData ?? this.membersData,
    );
  }
}