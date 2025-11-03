class NotificationItem {
  final String id;
  final String userId;
  final String message;
  final bool isRead;
  final DateTime timestamp;
  final TypeNotification type;

  NotificationItem({
    required this.type,
    required this.isRead,
    required this.id,
    required this.userId,
    required this.message,
    required this.timestamp,
  }); 

  factory NotificationItem.fromMap(Map<String, dynamic> map) {
    return NotificationItem(
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
}