import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/presentation/controllers/spots_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBarSpots extends StatefulWidget {
  final Function(Pico) onTapSuggestion;
  const SearchBarSpots({super.key, required this.onTapSuggestion});

  @override
  State<SearchBarSpots> createState() => _SearchBarSpotsState();
}

class _SearchBarSpotsState extends State<SearchBarSpots> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SpotsControllerProvider>(
      builder: (context, provider, child) => SearchAnchor.bar(
        viewHeaderHeight: 42,
        barLeading: Icon(
          Icons.search,
          size: 32,
          color: kRed,
        ),
        barBackgroundColor: const WidgetStatePropertyAll(kAlmostWhite),
        barHintText: "Pesquisar picos",
        onChanged: (value) => provider.pesquisandoPico(value),
        suggestionsBuilder: (context, controllerSearch) {
          if (provider.picosPesquisados.isEmpty) {
            return const [
              ListTile(
                title: Text('Nenhum resultado encontrado'),
              ),
            ];
          }

          return provider.picosPesquisados.map((pico) {
            return ListTile(
              title: Text(pico.picoName),
              onTap: () {
                controllerSearch.closeView(pico.id);
                controllerSearch.clear();
widget.onTapSuggestion(pico);
              } 
            );
          }).toList();
        },
        viewBackgroundColor: kAlmostWhite,
      ),
    );
  }
}
