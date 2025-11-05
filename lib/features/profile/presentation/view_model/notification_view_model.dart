import 'dart:async';

import 'package:demopico/features/profile/domain/models/notification.dart';
import 'package:demopico/features/profile/domain/usecases/watch_notifications_uc.dart';
import 'package:flutter/material.dart';

class NotificationViewModel extends ChangeNotifier {
  
  final WatchNotificationsUc _watchNotificationsUc;

  NotificationViewModel() : _watchNotificationsUc = WatchNotificationsUc();

  final List<NotificationItem> notifications = [];

  String? error;

  StreamSubscription? _notificationSub; 

  void initWatch(String idUser) {
    debugPrint("Inicializar notificações");
    debugPrint("notificações: ${notifications.length}");
    _notificationSub = _watchNotificationsUc.execute(idUser).listen(
      (onData) {
        notifications.clear();
        notifications.addAll(onData);
        notifyListeners();
      },
      onError: (error, st) {
        debugPrint("Erro ao listar as notificações: $error - stacktrace: $st");
        error = error.toString();
        notifyListeners();
      },
      cancelOnError: false,
    );
  }
  
  @override
  void dispose() {
    _notificationSub?.cancel();
    super.dispose();
  }
}