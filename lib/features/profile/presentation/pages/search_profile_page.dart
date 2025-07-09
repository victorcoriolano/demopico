import 'package:demopico/features/profile/presentation/widgets/search_page_widgets/suggest_profiles_widget.dart';
import 'package:flutter/material.dart';

class SearchProfilePage extends StatefulWidget {
  const SearchProfilePage({super.key});

  @override
  State<SearchProfilePage> createState() => _SearchProfilePageState();
}

class _SearchProfilePageState extends State<SearchProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Perfil'),
        centerTitle: true,
      ),
      body: Center(
         child: SuggestionProfilesWidget(
            name: 'Arthur Selingin',
            imageUrl:'https://avatars.githubusercontent.com/u/102646626?v=4', // Exemplo de URL de imagem
          )
      ),
    );
  }
}