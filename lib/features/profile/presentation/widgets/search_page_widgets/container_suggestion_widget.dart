import 'package:demopico/features/profile/presentation/widgets/search_page_widgets/suggetions_profiles_widget.dart';
import 'package:flutter/material.dart';

class ContainerSuggestionWidget extends StatelessWidget {


  const ContainerSuggestionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: const EdgeInsets.all(8.0),
      color: const Color.fromARGB(255, 231, 231, 231),
      width: MediaQuery.of(context).size.width * 1,
      child:ListView.builder(
        itemCount: 10, // Número de sugestões
        itemBuilder: (context, index) {
          return SuggestionProfilesWidget(
            name: 'Usuário $index',
            imageUrl: 'https://via.placeholder.com/150', // URL de exemplo
          );
        },
      ),
    );
  }

}