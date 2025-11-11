
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_notification_repository.dart';
import 'package:demopico/features/profile/domain/models/notification.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';
import 'package:demopico/features/profile/infra/repository/notification_repository_impl.dart';
import 'package:flutter/material.dart';

class RejectConnectionUc {
  static RejectConnectionUc? _instance;
  static RejectConnectionUc get instance {
    _instance ??= RejectConnectionUc(
      networkRepository: NetworkRepository.instance,
      notifyRepo: NotificationRepositoryImpl.getInstance
    );
    return _instance!;
  }

  final INetworkRepository _networkRepository;
  final INotificationRepository _notificationRepository;


  RejectConnectionUc({required INetworkRepository networkRepository,required INotificationRepository notifyRepo})
      : _networkRepository = networkRepository, _notificationRepository = notifyRepo;

  Future<void> execute(Relationship connection) async {
try{
  await  _networkRepository.deleteRelationship(connection.id);
  await _notificationRepository.createNotification(
        NotificationItem(
          type: TypeNotification.newUpdateOnCollective,
          isRead: false,
          id: "",
          userId: connection.requesterUser.id,
          message: "Conexão com ${connection.addressed.name} foi recusada",
          timestamp: DateTime.now(),
          data: null,
        ),
      );
}on Failure catch (e){
  debugPrint('UC - Erro ao deletar conexão: $e');
  rethrow;
}
  }
}