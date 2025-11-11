
import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/features/profile/domain/interfaces/i_coletivo_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_notification_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_repository.dart';
import 'package:demopico/features/profile/domain/models/notification.dart';
import 'package:demopico/features/profile/infra/repository/coletivo_repository_impl.dart';
import 'package:demopico/features/profile/infra/repository/notification_repository_impl.dart';
import 'package:demopico/features/profile/infra/repository/profile_repository.dart';
import 'package:flutter/widgets.dart';

class CreateCollectiveUc {
  final IColetivoRepository _repository;
  final IProfileRepository _profileRepository;
  final INotificationRepository _notificationRepository;

  static CreateCollectiveUc? _instance;
  static CreateCollectiveUc get instance =>
      _instance ??= CreateCollectiveUc(
        repository: ColetivoRepositoryImpl.instance, 
        profRepo: ProfileRepositoryImpl.getInstance,
        notificationRepository: NotificationRepositoryImpl.getInstance,
    );
  

  CreateCollectiveUc({
    required IColetivoRepository repository, 
    required IProfileRepository profRepo,
    required INotificationRepository notificationRepository,
  }): _repository = repository, _profileRepository = profRepo, _notificationRepository = notificationRepository;

  Future<ColetivoEntity> execute(ColetivoEntity coletivo, List<String> idcoletivos) async {
    debugPrint("Lista de idcoletivos do user atual: $idcoletivos - ${idcoletivos.length}");
    final newColetivo = await _repository.createColetivo(coletivo);
    idcoletivos.add(newColetivo.id);
    debugPrint("Lista de coletivos do user atual: $idcoletivos");
    await _profileRepository.updateField(id: coletivo.modarator.id, field: "idColetivos", newData: idcoletivos);
    if (coletivo.guests.isNotEmpty) {
      for (final user in coletivo.guests){
        await _notificationRepository.createNotification(
          NotificationItem(
            type: TypeNotification.inviteCollective,
            data: coletivo.id,
            isRead: false,
            id: "", 
            userId: user, 
            message: "Você foi convidado para o coletivo ${coletivo.nameColetivo}", 
            timestamp: DateTime.now()));
      }

    }
    return newColetivo;
  }
}