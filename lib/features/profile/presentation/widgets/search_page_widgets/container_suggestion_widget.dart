import 'package:demopico/features/profile/presentation/view_model/network_view_model.dart';
import 'package:demopico/features/profile/presentation/widgets/search_page_widgets/suggetions_profiles_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContainerSuggestionWidget extends StatelessWidget {
  const ContainerSuggestionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkViewModel>(builder: (context, viewModel, child) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.75,
        padding: const EdgeInsets.all(8.0),
        color: const Color.fromARGB(255, 231, 231, 231),
        width: MediaQuery.of(context).size.width * 1,
        child: viewModel.suggestions.isEmpty
            ? const Center(child: Text('Nenhuma sugestão disponível'))
            : ListView.builder(
                itemCount: viewModel.suggestions.length, // Número de sugestões
                itemBuilder: (context, index) {
                  return SuggestionProfilesWidget(
                    suggestionProfile: viewModel.suggestions[index],
                  );
                },
              ),
      );
    });
  }
}
