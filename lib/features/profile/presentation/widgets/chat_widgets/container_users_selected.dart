import 'package:demopico/features/profile/presentation/view_model/create_collective_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContainerSelectedUsers extends StatelessWidget {

  const ContainerSelectedUsers({ super.key });

   @override
   Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

       return Consumer<CreateCollectiveViewModel>(builder: (context, vm, child) {
              if (vm.members.isEmpty) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24.0),
                  child: Center(
                    child: Text(
                      'Os membros adicionados aparecerão aqui.',
                      style: textTheme.bodyMedium
                          ?.copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                  ),
                );
              } else {
                return Wrap(
                  spacing: 8.0, // Espaço horizontal entre os chips
                  runSpacing: 8.0, // Espaço vertical entre as linhas de chips
                  children: vm.members.map((user) {
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
                      onDeleted: () => vm.removeMember(user),
                    );
                  }).toList(),
                );
              }
            });
  }
}