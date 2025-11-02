import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/profile/domain/interfaces/i_notification_datasource.dart';
import 'package:demopico/features/profile/domain/interfaces/i_notification_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_data_source.dart';
import 'package:demopico/features/profile/domain/models/notification.dart';
import 'package:demopico/features/profile/domain/models/profile_user.dart';
import 'package:demopico/features/profile/infra/datasource/firebase_notification_datasource.dart';
import 'package:demopico/features/profile/infra/datasource/firebase_profile_datasource.dart';

class NotificationRepositoryImpl implements INotificationRepository {
    static NotificationRepositoryImpl? _instance;
  static NotificationRepositoryImpl get getInstance => _instance ??= NotificationRepositoryImpl();

  NotificationRepositoryImpl(): _datasource = FirebaseNotificationDatasource();

  final INotificationDatasource<FirebaseDTO> _datasource;




  @override
  Future<void> createNotification(NotificationItem notification) async {
    return await _datasource.createNotification(mapperNotificationModel.toDTO(notification));
  }

  @override
  Stream<List<NotificationItem>> watchNotifications(String idUser) {
    return _datasource.watchNotifications(idUser)
      .map((dtoList) => dtoList.map((dto) => mapperNotificationModel.toModel(dto)).toList());
  }

  @override
  Future<void> markNotificationAsRead(String userID, String notificationID) {
    return _datasource.updateNotification(userID, notificationID);
  }

}