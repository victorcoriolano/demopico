abstract interface class INotificationDatasource<DTO> {
  Future<void> createNotification(DTO notification);
  Stream<List<DTO>> watchNotifications(String idUser);
  Future<void> updateNotification(String userID, String notificationID);
} 