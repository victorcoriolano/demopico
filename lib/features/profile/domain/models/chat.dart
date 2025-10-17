import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/profile/domain/models/message.dart';

sealed class Chat {
  String get id;
  DateTime? get lastUpdate;
  List<UserIdentification> get participants;
  List<String> get participantsIds;

}

class Conversation extends Chat {
  @override
  final List<String> participantsIds;
  @override
  final String id;
  @override
  final DateTime? lastUpdate;
  final UserIdentification user1;
  final UserIdentification user2;
  final String? lastReadMessage;
  final String? lastMessage;
  @override
  final List<UserIdentification> participants;
  
  Conversation({
    required this.lastUpdate,
    required this.id,
    required this.lastMessage,
    required this.participants,
    required this.lastReadMessage,
    required this.participantsIds,
  }): user1 = participants[0], user2 = participants[1];

   factory Conversation.fromMap(Map<String, dynamic> map, String id) {
    try {
      return Conversation(
        lastUpdate: map["lastUpdate"] != null ? DateTime.tryParse(map["lastUpdate"]) : null,
      lastMessage: map["lastMessage"],
      id: id,
      lastReadMessage:map["lastReadMessage"],
      participantsIds: List<String>.from(map['participantsIds'] as List),
      participants: (map['participants'] as List).map((user) { 
        user = user as Map<String, dynamic>;
        return UserIdentification.fromJson(user);
      }).toList(),
    );
    } on TypeError catch (e){
      throw ArgumentError("Ocorreu um erro ao mapear os dados: $e ${e.stackTrace}");
    }
    
  }

  Map<String, dynamic> toJson() {
    return {
      'lastUpdate': lastUpdate?.toIso8601String(),
      'lastMessage': lastMessage,
      'lastReadMessage': lastReadMessage,
      'participantsIds': participantsIds,
      'participants': participants.map((user) => user.toJson()).toList(),
    };
  }

  factory Conversation.initFromUsers(UserIdentification currentUser, UserIdentification otherUser){
    return Conversation(
      lastUpdate: null,
      lastMessage: null, 
      participants: List.from([currentUser, otherUser]), 
      id: "", // sera inserido no bd
      lastReadMessage: null, 
      participantsIds: List.from([currentUser.id, otherUser.id]));
  }
}

class GroupChat extends Chat{
  @override
  final String id;
  final String nameGroup;
  @override
  final List<UserIdentification> participants;
  @override
  final List<String> participantsIds;
  final String? lastMessage;
  @override
  final DateTime? lastUpdate;

  GroupChat({
    required this.lastUpdate,
    required this.id,
    required this.lastMessage,
    required this.nameGroup,
    required this.participants,
    required this.participantsIds,
  });

  factory GroupChat.fromJson(Map<String,dynamic> data, String id){
    try{
      return GroupChat(
        lastUpdate: DateTime.tryParse(data["lastUpdate"]),
      id: id,
      lastMessage: data["lastMessage"], 
      nameGroup: data["nameGroup"] as String, 
      participants: List.from(data["participants"]), 
      participantsIds: List.from(data["participantsIds"]));
    } catch (e) {
      throw ArgumentError("Não foi possivel serializar os dados: ${e.toString()}");
    }
  }

  Map<String, dynamic> toJson(){
    return {
      "lastUpdate": lastUpdate?.toIso8601String(),
      "lastMessage": lastMessage,
      "nameGroup": nameGroup,
      "participants": participants.map((participant) => participant.toJson()).toList(),
      "participantsIds": participantsIds
    };
  }

}