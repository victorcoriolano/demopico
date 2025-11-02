
import 'package:demopico/features/profile/domain/interfaces/i_notification_repository.dart';
import 'package:demopico/features/profile/domain/models/notification.dart';
import 'package:demopico/features/profile/infra/repository/notification_repository_impl.dart';

class WatchNotificationsUc {
  final INotificationRepository _repository;

  //TODO: corrigir erro de navegação pra tela de chats 
  //TODO: corrigir erro logout/login - esta pegando os dados do user antigo
  //TODO: CORRIGIR OS TESTES
  //TODO: IMPLEMENTAR MÉTODOS DO REPOSITORY QUE FICARAM FALTANDO
  

  WatchNotificationsUc() : _repository = NotificationRepositoryImpl();

  Stream<List<NotificationItem>> execute(String idUser) {
    return _repository.watchNotifications(idUser);
  }
} 

