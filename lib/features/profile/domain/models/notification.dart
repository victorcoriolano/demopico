class NotificationItem {
  final String id;
  final String userId;
  final String message;
  final bool isRead;
  final DateTime timestamp;
  final TypeNotification type;
  final String? data;

  NotificationItem({
    required this.type,
    required this.isRead,
    required this.id,
    required this.userId,
    required this.message,
    required this.timestamp,
    required this.data,
  }); 

  factory NotificationItem.fromMap(Map<String, dynamic> map) {
    return NotificationItem(
      data: map['data'],
      id: map['id'],
      userId: map['userId'],
      message: map['message'],
      isRead: map['isRead'],
      timestamp: DateTime.parse(map['timestamp']),
      type: TypeNotification.values.firstWhere((t) => t.name == map['type']),
    );  
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'message': message,
      'isRead': isRead,
      'timestamp': timestamp.toIso8601String(),
      'type': type.name,
      'data': data,
    };  
  }
}

enum TypeNotification {
  inviteCollective,
  newPostCollective,
  newLikeOnPub,
  newCommentOnPub,  
  newMessage,
  newUpdateOnCollective,
  newRelactionshipRequest,
}