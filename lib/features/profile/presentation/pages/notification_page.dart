import 'package:demopico/features/profile/presentation/view_model/notification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {

  const NotificationPage({ super.key });
   @override
   Widget build(BuildContext context) {
       return Scaffold(
            appBar: AppBar(title: const Text('Notifications'),),
            body: Consumer<NotificationViewModel>(
              builder: (context, vm, child) {
                if (vm.notifications.isEmpty){
                  return Center(child: Text("Nenhuma notificação por enquanto"),);
                }

                if (vm.error != null){
                  return Center(child: Text("Ocorreu um erro ao pegar as notificações "),);
                }

                return ListView.builder(
                  itemCount: vm.notifications.length,
                  itemBuilder: (context, item) {
                    final notification = vm.notifications[item];
                    return ListTile(
                      title: Text(
                        notification.message, 
                        style: TextStyle(
                          fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold
                        ),),  
                    );
                  }
                );
              },
            ),
        );
  }
}