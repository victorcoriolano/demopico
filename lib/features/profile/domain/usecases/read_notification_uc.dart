
import 'package:demopico/features/profile/domain/interfaces/i_notification_repository.dart';
import 'package:demopico/features/profile/domain/models/notification.dart';
import 'package:demopico/features/profile/infra/repository/notification_repository_impl.dart';

class ReadNotificationUc {
  final INotificationRepository _repository;

  ReadNotificationUc() : _repository = NotificationRepositoryImpl();

  Future<void> execute(String idUser, String notificationId) {
    return _repository.markNotificationAsRead(idUser, notificationId);
  }
} 

