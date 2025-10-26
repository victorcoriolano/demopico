class NotificationItem {
  final String id;
  final String userId;
  final String message;
  final bool isRead;
  final DateTime timestamp;

  NotificationItem({
    required this.isRead,
    required this.id,
    required this.userId,
    required this.message,
    required this.timestamp,
  }); 
}