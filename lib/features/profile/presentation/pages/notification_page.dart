import 'package:demopico/features/profile/presentation/view_model/notification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {

  const NotificationPage({ super.key });
    //TODO CRIAR TELA DE NOTIFICAÇÕES
   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Notifications'),),
           body: Consumer<NotificationViewModel>(builder: (context, viewModel, child) {
             
             return Container();
           })
       );
  }
}