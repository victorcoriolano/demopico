import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';

class Message {
  final String id;
  final String content;
  final UserIdentification infoUser;
  final DateTime dateTime;
  final bool isRead;
  final String? spotId;
  final String? postId;  

  const Message({
    required this.id,
    required this.content,
    required this.dateTime,
    required this.infoUser,
    required this.isRead,
    this.postId,
    this.spotId,
  });


  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      content: map['content'] as String,
      infoUser: UserIdentification.fromJson(map['infoUser'] as Map<String,dynamic>),
      dateTime: DateTime.parse(map['dateTime'] as String),
      isRead: map['isRead'] as bool,
      spotId: map['spotId'] as String?,
      postId: map['postId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'infoUser': infoUser.toJson(),
      'dateTime': dateTime.toIso8601String(),
      'isRead': isRead,
      'spotId': spotId,
      'postId': postId,
    };
  }

  factory Message.initial(UserIdentification currentUser, String content){
    return Message(
      id: "", 
      content: content, 
      dateTime: DateTime.now(), 
      infoUser: currentUser, 
      isRead: false,
    );
  }
}