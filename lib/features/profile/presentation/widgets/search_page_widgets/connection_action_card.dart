import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/presentation/pages/profile_page_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectionActionCard extends StatefulWidget {
  final BasicInfoUser user;
  final Widget actionButton;

  const ConnectionActionCard({ super.key, required this.actionButton, required this.user  });

  @override
  State<ConnectionActionCard> createState() => _ConnectionActionCardState();
}

class _ConnectionActionCardState extends State<ConnectionActionCard> {

   @override
   Widget build(BuildContext context) {
       return ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(
              widget.user.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            trailing: widget.actionButton,
            onTap: () {
              
              Get.to(() => ProfilePageUser(), arguments: widget.user.id);
            },
          );
  }
}