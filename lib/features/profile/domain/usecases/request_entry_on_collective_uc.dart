import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/features/profile/domain/interfaces/i_coletivo_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_notification_repository.dart';
import 'package:demopico/features/profile/domain/models/notification.dart';
import 'package:demopico/features/profile/infra/repository/coletivo_repository_impl.dart';
import 'package:demopico/features/profile/infra/repository/notification_repository_impl.dart';
import 'package:flutter/material.dart';

class RequestEntryOnCollectiveUc {
  final IColetivoRepository _repository;
  final INotificationRepository _notificationRepository;

  RequestEntryOnCollectiveUc()
      : _repository = ColetivoRepositoryImpl.instance,
        _notificationRepository = NotificationRepositoryImpl.getInstance;

  Future<ColetivoEntity> execute({
    required ColetivoEntity coletivo,
    required UserIdentification user,
  }) async {
    if (coletivo.entryRequests.contains(user.id)) throw AnotherFailure(message: "Usuário já solicitou a entrada");
    final listEntryRequests = coletivo.entryRequests;
    debugPrint('lista atual: ${coletivo.entryRequests.length}');
    listEntryRequests.add(user.id);
    coletivo = coletivo.copyWith(entryRequests: listEntryRequests);
    debugPrint('lista alterada: ${coletivo.entryRequests.length}');
    final listEntry = listEntryRequests
        .toSet(); // transformando em set para remover duplicados
    final notification = NotificationItem(
        type: TypeNotification.newUpdateOnCollective,
        isRead: false,
        id: "",
        userId: coletivo.modarator.id,
        message: "User ${user.name} solicitou a entrada no coletivo ${coletivo.nameColetivo}",
        timestamp: DateTime.now(),
        data: user.id,
    );
    _notificationRepository.createNotification(notification);
    await _repository.updateListOnCollective(
        nameField: "entryRequests",
        idCollective: coletivo.id,
        newListData: listEntry.toList());
    return coletivo;
  }
}
