import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/features/profile/presentation/view_model/network_view_model.dart';
import 'package:demopico/features/profile/presentation/widgets/search_page_widgets/container_suggestion_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/search_page_widgets/historic_profile_list.dart';
import 'package:demopico/features/profile/presentation/widgets/search_page_widgets/not_searching_view.dart';
import 'package:demopico/features/profile/presentation/widgets/search_page_widgets/suggetions_profiles_widget.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SearchProfilePage extends StatefulWidget {
  const SearchProfilePage({super.key});

  @override
  State<SearchProfilePage> createState() => _SearchProfilePageState();
}

class _SearchProfilePageState extends State<SearchProfilePage> {
  final TextEditingController _searchController = TextEditingController();
  

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentUser = context.read<AuthViewModelAccount>().user;
      switch (currentUser) {
        case UserEntity():
          context.read<NetworkViewModel>().fetchSugestions(currentUser);
        case AnonymousUserEntity():
        // do nothing
      }
    });
  }

  @override
  Widget build(BuildContext context) {
      final theme = Theme.of(context);
      final textTheme = theme.textTheme;
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Buscar Perfil'),
        centerTitle: true,
        elevation: 0.5,
        actions: [
          IconButton(
            icon: const Icon(Icons.workspaces_rounded, size: 35,),
            tooltip: 'Minha Rede',
            onPressed: () => Get.toNamed(Paths.myNetwork),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2,
              shadowColor: kWhite,
              borderRadius: BorderRadius.circular(16),
              child: TextField(
                controller: _searchController,
                cursorColor: theme.colorScheme.primary,
                decoration: InputDecoration(
                  hintText: 'Pesquisar usuários...',
                  hintStyle: textTheme.bodyMedium?.copyWith(
                    color: theme.hintColor.withValues(alpha: 0.7),
                  ),
                  prefixIcon: Icon(Icons.search, color: theme.iconTheme.color),
                  filled: true,
                  fillColor: kAlmostWhite,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (query) {
                  // opcional: acionar busca dinâmica
                  context.read<NetworkViewModel>().setIsSearching = true;
                },
                onSubmitted: (value) => context.read<NetworkViewModel>().setIsSearching = true,
              ),
            ),

            Consumer<NetworkViewModel>(
              builder: (context, vm, child) {
                final user = context.read<AuthViewModelAccount>().user as UserEntity;
                return vm.isSearching && _searchController.text.isNotEmpty
                ? Expanded(
                  child: ListView.builder(
                    itemCount: vm.searchUser(_searchController.text, user).length,
                    itemBuilder: (context, index) {
                      final listUser = vm.searchUser(_searchController.text, user);
                      return SuggestionProfilesWidget(suggestionProfile: listUser[index]);
                    },
                  ),
                )
                : NotSearchingView();
              }
            ),
          ],
        ),
      ),
    );
  }
}
