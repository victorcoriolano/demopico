import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/core/common/media_management/models/file_model.dart';
import 'package:demopico/features/mapa/presentation/widgets/spot_info_widgets/custom_buttons.dart';
import 'package:demopico/features/profile/domain/models/profile_user.dart';
import 'package:demopico/features/profile/presentation/object_for_only_view/suggestion_profile.dart';
import 'package:demopico/features/profile/presentation/view_model/create_collective_view_model.dart';
import 'package:demopico/features/profile/presentation/view_model/network_view_model.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CreateCollectivePage extends StatefulWidget {
  final Profile user;
  const CreateCollectivePage({super.key, required this.user});

  @override
  State<CreateCollectivePage> createState() => _CreateCollectivePageState();
}

class _CreateCollectivePageState extends State<CreateCollectivePage> {
  final TextEditingController _nameCollectiveController = TextEditingController();

  @override
  void dispose() {
    _nameCollectiveController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar coletivo'),
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SEÇÃO 1: NOME DO COLETIVO ---

           Text(
              "Nome do Coletivo",
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0), // Espaço menor entre label e campo

            TextFormField(
              controller: _nameCollectiveController,
              decoration: const InputDecoration(
                hintText: 'Ex: OS+SEMROLAMENTO',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => context.read<CreateCollectiveViewModel>().nameCollective = value,
            ),
            const SizedBox(height: 24.0), 

            // --- SEÇÃO 2: IMAGEM DO COLETIVO ---

            Text(
              "Imagem do Coletivo",
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Consumer<CreateCollectiveViewModel>(
              builder: (context, vm, child) {
                if (vm.photoCollective is NullFileModel){
                  return OutlinedButton.icon(
                  onPressed: () async {
                    await context.read<CreateCollectiveViewModel>().addImage();
                  },
                  icon: Icon(
                    Icons.add_a_photo_outlined, // Ícone mais leve
                    color: colorScheme.onSurface.withValues(alpha: .7),
                  ),
                  label: Text(
                    'Selecione uma imagem',
                    style: TextStyle(
                      color: colorScheme.onSurface.withValues(alpha: .7),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 60), // Ocupa a largura
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Borda padrão
                    ),
                  ),
                );
                }
                else {
                  return Image.memory(
                    vm.photoCollective.bytes,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image)
                  );
                }
                
              }
            ),
            const SizedBox(height: 24.0), // Espaço maior entre seções

            // --- SEÇÃO 3: MEMBROS ---

            Text(
              "Membros",
              style: textTheme.titleMedium, // Consistência de título
            ),
            const SizedBox(height: 12.0),

            Consumer<NetworkViewModel>(builder: (context, provider, child) {
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
                barHintText: "Adicionar membros",
                onChanged: (value) {
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
                            context
                                .read<CreateCollectiveViewModel>()
                                .addMember(suggestion);
                            controllerSearch.closeView(suggestion.name);

                          },
                          icon: Icon(Icons.add)),
                      onTap: () {
                        context
                            .read<CreateCollectiveViewModel>()
                            .addMember(suggestion);
                        controllerSearch.closeView(suggestion.name);
                      },
                    );
                  }).toList();
                },
                viewBackgroundColor: colorScheme.surface, // Cor do tema
              );
            }),

            const SizedBox(height: 16.0), // Espaço entre a busca e os chips

            Consumer<CreateCollectiveViewModel>(builder: (context, vm, child) {
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
            }),
            const SizedBox(height: 16.0),
            Center(
              child: Consumer<CreateCollectiveViewModel>(
                builder: (context, vm, child) {
                  return CustomElevatedButton(
                    onPressed: vm.validateForCreate() 
                    ? () {
                        context.read<CreateCollectiveViewModel>().createCollective(widget.user);
                      }
                    : null,
                    textButton: "Criar Coletivo",
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}