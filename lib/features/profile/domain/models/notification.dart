class Notification {
  final String id;
  final String userId;
  final String message;
  bool isRead;
  final DateTime timestamp;

  Notification({
    required this.isRead,
    required this.id,
    required this.userId,
    required this.message,
    required this.timestamp,
  });

  
}