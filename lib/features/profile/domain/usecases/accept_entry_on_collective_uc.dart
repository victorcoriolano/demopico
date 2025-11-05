import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/profile/domain/interfaces/i_coletivo_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_message_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_notification_repository.dart';
import 'package:demopico/features/profile/domain/models/notification.dart';
import 'package:demopico/features/profile/infra/repository/chat_repository.dart';
import 'package:demopico/features/profile/infra/repository/coletivo_repository_impl.dart';
import 'package:demopico/features/profile/infra/repository/notification_repository_impl.dart';
import 'package:flutter/material.dart';

class AcceptEntryOnCollectiveUc {
  final IColetivoRepository _coletivoRepository;
  final INotificationRepository _notificationRepository;
  final ImessageRepository _imessageRepository;

  AcceptEntryOnCollectiveUc()
      : _coletivoRepository = ColetivoRepositoryImpl.instance,
        _notificationRepository = NotificationRepositoryImpl(),
        _imessageRepository = ChatRepository.instance;

  Future<ColetivoEntity> execute(
      UserIdentification user, ColetivoEntity coletivo) async {
    final listRequestsEntry = coletivo.entryRequests;
    final listMembers = coletivo.members;
    if (!listRequestsEntry.contains(user.id)) throw AnotherFailure(message: "Usuário não requisitou a entrada ainda");
    listRequestsEntry.remove(user.id);
    if (listMembers.contains(user)) throw AnotherFailure(message: "Usuário já é um membro");
    listMembers.add(user);

    coletivo = coletivo.copyWith(
        entryRequests: listRequestsEntry, members: listMembers);
    

    try {
      await _coletivoRepository.updateColetivo(coletivo);
      // adicionado user ao chat
      await _imessageRepository.addUserOnGroup(
          coletivo.id, listMembers.map((u) => u.id).toList());
      //notificando o usuário
      final notify = NotificationItem(
          type: TypeNotification.newUpdateOnCollective,
          isRead: false,
          id: "",
          userId: user.id,
          message: "Você foi aceito no coletivo ${coletivo.nameColetivo}",
          timestamp: DateTime.now());

      _notificationRepository.createNotification(notify);
      return coletivo;
    } on Failure catch (failure) {
      debugPrint("UC erro ao aceitar usuário no coletivo: $failure");
      rethrow;
    }
  }
}
