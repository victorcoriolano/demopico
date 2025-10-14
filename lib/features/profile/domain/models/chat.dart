import 'package:demopico/features/profile/domain/models/message.dart';

class Chat {
  final List<String> participants;
  final String id;
  final Message lastMessage;
  
  Chat({
    required this.id,
    required this.lastMessage,
    required this.participants,
  });

   factory Chat.fromMap(Map<String, dynamic> map, String id) {
    return Chat(
      id: id,
      lastMessage: Message.fromMap(map['lastMessage'] as Map<String, dynamic>, map["lastMessage.id"]),
      participants: List<String>.from(map['participants'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lastMessage': lastMessage.toJson(),
      'participants': participants,
    };
  }
}