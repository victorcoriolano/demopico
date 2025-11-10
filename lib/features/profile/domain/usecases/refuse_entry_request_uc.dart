import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/features/profile/domain/interfaces/i_coletivo_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_notification_repository.dart';
import 'package:demopico/features/profile/domain/models/notification.dart';
import 'package:demopico/features/profile/infra/repository/coletivo_repository_impl.dart';
import 'package:demopico/features/profile/infra/repository/notification_repository_impl.dart';
import 'package:flutter/material.dart';

class RefuseEntryRequestUseCase {
  final IColetivoRepository _repository;
  final INotificationRepository _notificationRepository;

  RefuseEntryRequestUseCase() : 
    _repository = ColetivoRepositoryImpl.instance,
    _notificationRepository = NotificationRepositoryImpl.getInstance;

  Future<ColetivoEntity> execute({
    required String userId,
    required ColetivoEntity coletivo,
  }) async {
    try {
      final updatedRequests = List<String>.from(coletivo.entryRequests)..remove(userId);

      debugPrint('Removendo requisição de entrada: $userId');
      await _repository.updateListOnCollective(
        nameField: "entryRequests",
        idCollective: coletivo.id,
        newListData: updatedRequests,
      );

      await _notificationRepository.createNotification(
        NotificationItem(
          type: TypeNotification.newUpdateOnCollective,
          isRead: false,
          id: "",
          userId: userId,
          message: "Sua solicitação de entrada no coletivo ${coletivo.nameColetivo} foi recusada",
          timestamp: DateTime.now(),
        ),
      );

      debugPrint('Notificação enviada para o usuário $userId sobre recusa de entrada.');
      return coletivo;
    } on Failure catch (e) {
      debugPrint('Erro ao recusar solicitação de entrada: $e');
      rethrow;
    }
  }
}
