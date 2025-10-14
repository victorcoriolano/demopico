import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/profile/domain/models/message.dart';

sealed class Chat {}

class Conversation extends Chat {
  final List<String> participantsIds;
  final String id;
  final UserIdentification user1;
  final UserIdentification user2;
  final Message lastReadMessage;
  final Message lastMessage;
  final List<UserIdentification> participants;
  
  Conversation({
    required this.lastMessage,
    required this.participants,
    required this.id,
    required this.lastReadMessage,
    required this.participantsIds,
  }): user1 = participants[0], user2 = participants[1];

   factory Conversation.fromMap(Map<String, dynamic> map, String id) {
    return Conversation(
      lastMessage: Message.fromMap(map['lastReadMessage'] as Map<String, dynamic>, map["lastReadMessage.id"]),
      id: id,
      lastReadMessage: Message.fromMap(map['lastReadMessage'] as Map<String, dynamic>, map["lastReadMessage.id"]),
      participantsIds: List<String>.from(map['participantsIds'] as List),
      participants: (map['participants'] as List).map((user) { 
        user = user as Map<String, dynamic>;
        return UserIdentification.fromJson(user);
      }).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lasMessage': lastMessage.toJson(),
      'lastReadMessage': lastReadMessage.toJson(),
      'participantsIds': participantsIds,
      'participants': participants.map((user) => user.toJson()),
    };
  }
}

class GroupChat extends Chat{
  final String nameGroup;
  final List<UserIdentification> participants;
  final List<String> participantsIds;
  final Message lastMessage;

  GroupChat({
    required this.lastMessage,
    required this.nameGroup,
    required this.participants,
    required this.participantsIds,
  });

}