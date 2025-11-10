import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/features/profile/presentation/object_for_only_view/suggestion_profile.dart';
import 'package:demopico/features/profile/presentation/view_model/network_view_model.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBarUsers extends StatelessWidget {
  final Function(SuggestionProfile) onTapSuggestion;
  final String? hint;

  const SearchBarUsers({ this.hint,super.key , required this.onTapSuggestion});

   @override
   Widget build(BuildContext context) {
        
    final colorScheme = Theme.of(context).colorScheme;
       return Consumer<NetworkViewModel>(builder: (context, provider, child) {
              List<SuggestionProfile> listSuggetions = [];
              return SearchAnchor.bar(
                viewHeaderHeight: 35,
                barLeading: Icon(
                  Icons.search,
                  size: 28, // Tamanho sutil
                  color: colorScheme.primary, // Cor do tema (substitui kRed)
                ),
                barBackgroundColor: WidgetStatePropertyAll(
                  colorScheme.surface.withValues(alpha: .5), // Cor do tema
                ),
                barHintText: hint ?? "Adicionar membros",
                onChanged: (value)  async {
                  final user =
                      context.read<AuthViewModelAccount>().user as UserEntity;
                  listSuggetions = provider.searchUser(value, user);
                },
                suggestionsBuilder: (context, controllerSearch) {
                  // ... (lógica de sugestões mantida) ...
                  if (listSuggetions.isEmpty) {
                    return const [
                      ListTile(
                        title: Text('Nenhum resultado encontrado'),
                      ),
                    ];
                  }

                  return listSuggetions.map((suggestion) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: suggestion.photo != null
                            ? NetworkImage(suggestion.photo!)
                            : null,
                        onBackgroundImageError: suggestion.photo != null
                            ? (error, st) => Icon(Icons.broken_image)
                            : null,
                      ),
                      title: Text(suggestion.name),
                      trailing: IconButton(
                          onPressed: () {
                            onTapSuggestion(suggestion);
                            controllerSearch.closeView( suggestion.name);
                          },
                          icon: Icon(Icons.add)),
                      onTap: () {
                        onTapSuggestion(suggestion);
                        controllerSearch.closeView( suggestion.name);
                      },
                    );
                  }).toList();
                },
                viewBackgroundColor: colorScheme.surface, // Cor do tema
              );
            });
  }
}