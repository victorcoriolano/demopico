import 'package:demopico/features/profile/domain/models/relationship.dart';

class Message {
  final String id;
  final String content;
  final BasicInfoUser infoUser;
  final DateTime dateTime;
  final bool isRead;
  final bool isSent;
  final String? spotId;
  final String? postId;  

  const Message({
    required this.id,
    required this.isSent,
    required this.content,
    required this.dateTime,
    required this.infoUser,
    required this.isRead,
    this.postId,
    this.spotId,
  });


  factory Message.fromMap(Map<String, dynamic> map, String id) {
    return Message(
      id: id,
      content: map['content'] as String,
      infoUser: BasicInfoUser.fromJson(map['infoUser'] as Map<String,dynamic>),
      dateTime: DateTime.parse(map['dateTime'] as String),
      isRead: map['isRead'] as bool,
      isSent: map['isSent'] as bool,
      spotId: map['spotId'] as String?,
      postId: map['postId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'infoUser': infoUser.toJson(),
      'dateTime': dateTime.toIso8601String(),
      'isRead': isRead,
      'isSent': isSent,
      'spotId': spotId,
      'postId': postId,
    };
  }
}