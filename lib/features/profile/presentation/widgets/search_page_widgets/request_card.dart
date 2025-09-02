import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/presentation/pages/my_network_page.dart';
import 'package:flutter/material.dart';

class RequestCard extends StatefulWidget {
  final ReciverRequesterBase relationship;
  final Widget actionButton;

  const RequestCard({ super.key, required this.actionButton, required this.relationship  });

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {

   @override
   Widget build(BuildContext context) {
       return ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(
              widget.relationship.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            trailing: widget.actionButton,
          );
  }
}