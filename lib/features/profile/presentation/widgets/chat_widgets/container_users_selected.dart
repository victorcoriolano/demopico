import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/profile/presentation/view_model/create_collective_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContainerSelectedUsers extends StatelessWidget {
  final List<UserIdentification> members;
  final void Function(UserIdentification) onRemoveMember;
  final String? hint;

  const ContainerSelectedUsers({ this.hint, super.key , required this.members, required this.onRemoveMember  });

   @override
   Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

       
              if (members.isEmpty) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Text(
                      hint ?? 'Os membros adicionados aparecerão aqui.',
                      style: textTheme.bodyMedium
                          ?.copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                  ),
                );
              } else {
                return Wrap(
                  spacing: 8.0, // Espaço horizontal entre os chips
                  runSpacing: 8.0, // Espaço vertical entre as linhas de chips
                  children: members.map((user) {
                    return Chip(
                      avatar: CircleAvatar(
                        backgroundImage: user.profilePictureUrl != null
                            ? NetworkImage(user.profilePictureUrl!)
                            : null,
                        // Adiciona um ícone de fallback
                        child: user.profilePictureUrl == null
                            ? const Icon(Icons.person, size: 18)
                            : null,
                      ),
                      label: Text(user.name),
                      onDeleted: () => onRemoveMember(user),
                      deleteIcon: const Icon(Icons.close),
                      deleteIconColor: colorScheme.error,
                    );
                  }).toList(),
                );
              }
   
  }
}