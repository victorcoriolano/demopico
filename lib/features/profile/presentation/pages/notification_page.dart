import 'package:demopico/features/mapa/presentation/widgets/spot_info_widgets/custom_buttons.dart';
import 'package:demopico/features/profile/domain/models/notification.dart';
import 'package:demopico/features/profile/presentation/view_model/notification_view_model.dart';
import 'package:demopico/features/profile/presentation/view_model/screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {

  const NotificationPage({ super.key });

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      final vm = context.read<NotificationViewModel>();
      final notifications = vm.notifications;

      for (final notif in notifications){
        vm.readNotifications(notif.id);
      }
    });
  }
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
                      trailing: 
                        switch (notification.type){
                          
                          // TODO: Handle invite Collective.
                          TypeNotification.inviteCollective => throw UnimplementedError(),
                          // TODO: Handle new Post on Collective.
                          TypeNotification.newPostCollective => throw UnimplementedError(),
                          // TODO: Handle new Like on pub.
                          TypeNotification.newLikeOnPub => throw UnimplementedError(),
                          // TODO: Handle new comment on pub.
                          TypeNotification.newCommentOnPub => throw UnimplementedError(),
                          
                          TypeNotification.newMessage => CustomElevatedButton(
                            onPressed: () {
                              context.read<ScreenProvider>().setIndex(2);
                              Get.back();
                            } , textButton: "Ver Mensagem"),
                          TypeNotification.newUpdateOnCollective => Icon(Icons.check)
                        },
                      subtitle: Text(
                        '${notification.timestamp.day}/${notification.timestamp.month}/${notification.timestamp.year}   ${notification.timestamp.hour}:${notification.timestamp.minute.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),

                    );

                  }
                );
              },
            ),
        );
  }
}