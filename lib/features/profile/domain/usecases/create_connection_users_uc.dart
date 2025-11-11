
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_notification_repository.dart';
import 'package:demopico/features/profile/domain/models/notification.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';
import 'package:demopico/features/profile/infra/repository/notification_repository_impl.dart';
import 'package:flutter/material.dart';

class CreateConnectionUsersUc {
  final INetworkRepository _repository;
  final INotificationRepository _notificationRepository;

  static CreateConnectionUsersUc? _instance;

  static CreateConnectionUsersUc get instance {
    _instance ??= CreateConnectionUsersUc(
      repository: NetworkRepository.instance,
      notificationRepository: NotificationRepositoryImpl.getInstance
    );
    return _instance!;
  }

  CreateConnectionUsersUc({required INetworkRepository repository, required INotificationRepository notificationRepository })
      : _repository = repository, _notificationRepository = notificationRepository;

  Future<Relationship> execute(Relationship connection) async {
    try {
      final output = await _repository.createRelationship(connection);
      /// NOTIFICAÇÃO DE USUÁRIOS 
      /// o user receptor da requsição de amizade deverá ser notificado 
      final notification = NotificationItem(
        data: connection.requesterUser.id,
        type: TypeNotification.newRelactionshipRequest, 
        isRead: false, id: "", 
        userId: connection.addressed.id, 
        message: "${connection.requesterUser.name} quer ser seu amigo", timestamp: DateTime.now());

      _notificationRepository.createNotification(notification); 
      
      return output;
    } on Failure catch (e) {
      debugPrint('UC - Erro ao criar conexão: $e');
      rethrow;
    }
  
    
  }
}