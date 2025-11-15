import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/core/common/mixins/route_profile_validator.dart';
import 'package:demopico/features/user/domain/enums/auth_state.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:flutter/material.dart';


class ConnectionActionCard extends StatefulWidget {
  final UserIdentification user;
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
               AuthState userActual = AuthViewModelAccount.instance.authState;
                RouteProfileValidator.validateRoute(userActual, widget.user.id);
            },
          );
  }
}