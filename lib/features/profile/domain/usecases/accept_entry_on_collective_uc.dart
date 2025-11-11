import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/core/common/auth/domain/interfaces/i_user_repository.dart';
import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/profile/domain/interfaces/i_coletivo_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_message_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_notification_repository.dart';
import 'package:demopico/features/profile/domain/models/notification.dart';
import 'package:demopico/features/profile/infra/repository/chat_repository.dart';
import 'package:demopico/features/profile/infra/repository/coletivo_repository_impl.dart';
import 'package:demopico/features/profile/infra/repository/notification_repository_impl.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:flutter/material.dart';

class AcceptEntryOnCollectiveUc {
  final IColetivoRepository _coletivoRepository;
  final INotificationRepository _notificationRepository;
  final ImessageRepository _imessageRepository;
  final IUserRepository _userRepository;


  AcceptEntryOnCollectiveUc()
      : _coletivoRepository = ColetivoRepositoryImpl.instance,
        _notificationRepository = NotificationRepositoryImpl(),
        _imessageRepository = ChatRepository.instance,
        _userRepository = UserDataRepositoryImpl.getInstance;


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
          nameChat: coletivo.nameColetivo, listMembers.map((u) => u.id).toList());
      //notificando o usuário
      final notification = NotificationItem(
          type: TypeNotification.newUpdateOnCollective,
          isRead: false,
          data: coletivo.id,
          id: "",
          userId: user.id,
          message: "🥳 Você foi aceito no coletivo ${coletivo.nameColetivo}",
          timestamp: DateTime.now());
      _notificationRepository.createNotification(notification);

      return coletivo;
    } on Failure catch (failure) {
      debugPrint("UC erro ao aceitar usuário no coletivo: $failure");
      rethrow;
    }
  }
}
