import 'package:cached_network_image/cached_network_image.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/presentation/pages/profile_page_user.dart';
import 'package:demopico/features/profile/presentation/view_model/network_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyFriendsPage extends StatefulWidget {

  const MyFriendsPage({ super.key });

  @override
  State<MyFriendsPage> createState() => _MyFriendsPageState();
}

class _MyFriendsPageState extends State<MyFriendsPage> {
  final String idUser  = Get.arguments as String;
  final List<UserIdentification> friends = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async { 
      final vm = context.read<NetworkViewModel>();
      await vm.fetchAcceptedConnections(idUser);
      friends.addAll(vm.connAccepted(idUser));
      debugPrint('friends: $friends');
      setState(() {});
    });
  }

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('CONEXÕES'),),
           body: ListView.builder(
            itemCount: friends.length,
            itemBuilder: (context, index) {
              final friend = friends[index];
              return ListTile(
                title: Text(friend.name),
                leading: CircleAvatar(
                  backgroundImage: friend.profilePictureUrl != null ? CachedNetworkImageProvider(friend.profilePictureUrl!) : null,
),
                trailing: IconButton(
                  onPressed: () {
                    
                  }, 
                  icon: Icon(Icons.chat)),
                onTap: () {
                  debugPrint(" Chamando a profile do user: ${friend.id} - ${friend.name}");
                  Get.to(() => ProfilePageUser(), arguments: friend.id);
                },
              );
            },
            ),
       );
  }
}