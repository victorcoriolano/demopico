import 'package:demopico/features/profile/domain/models/notification.dart';

abstract interface class INotificationRepository {
  Future<void> createNotification(NotificationItem notification);
  Stream<List<NotificationItem>> watchNotifications(String idUser);
  Future<void> markNotificationAsRead(String userID, String notificationID);
}