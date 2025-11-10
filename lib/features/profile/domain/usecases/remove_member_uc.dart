import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/profile/domain/interfaces/i_coletivo_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_notification_repository.dart';
import 'package:demopico/features/profile/domain/models/notification.dart';
import 'package:demopico/features/profile/infra/repository/coletivo_repository_impl.dart';
import 'package:demopico/features/profile/infra/repository/notification_repository_impl.dart';
import 'package:flutter/material.dart';

class RemoveMemberUseCase {
  final IColetivoRepository _repository;
  final INotificationRepository _notificationRepository;

  RemoveMemberUseCase(): 
    _repository = ColetivoRepositoryImpl.instance,
    _notificationRepository = NotificationRepositoryImpl.getInstance;

  Future<void> execute({
    required UserIdentification user,
    required ColetivoEntity coletivo,
  }) async {
    try {
      final updatedMembers = List<UserIdentification>.from(coletivo.members)..remove(user);

      debugPrint('Removendo membro: ${user.id}');
      await _repository.updateListOnCollective(
        nameField: "members",
        idCollective: coletivo.id,
        newListData: updatedMembers,
      );

      await _notificationRepository.createNotification(
        NotificationItem(
          type: TypeNotification.newUpdateOnCollective,
          isRead: false,
          id: "",
          userId: user.id,
          message: "Você foi removido do coletivo ${coletivo.nameColetivo}",
          timestamp: DateTime.now(),
        ),
      );

      debugPrint('Notificação enviada para o usuário ${user.id} sobre remoção.');

    } on Failure catch (e) {
      debugPrint('Erro ao remover membro do coletivo: $e');
      rethrow;
    }
  }
}
