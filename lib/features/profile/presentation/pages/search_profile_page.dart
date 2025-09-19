import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/features/profile/presentation/services/verify_auth_and_get_user.dart';
import 'package:demopico/features/profile/presentation/view_model/network_view_model.dart';
import 'package:demopico/features/profile/presentation/widgets/search_page_widgets/container_suggestion_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SearchProfilePage extends StatefulWidget {
  const SearchProfilePage({super.key});

  @override
  State<SearchProfilePage> createState() => _SearchProfilePageState();
}

class _SearchProfilePageState extends State<SearchProfilePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentUser = VerifyAuthAndGetUser.verify(context);
      if (currentUser != null) context.read<NetworkViewModel>().fetchSugestions(currentUser);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Perfil'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.south_america_outlined),
            onPressed: () {
              Get.toNamed(Paths.myNetwork);
            },
          ),
        ],
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Pesquisar',
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(child: ContainerSuggestionWidget()),
        ],
      ),
          
    );
  }
}