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
    // Texto para list tile quando acabou de abrir a search bar ou quando não há resultados
    String emptyText = 'Digite algo para pesquisar';
    return Consumer<SpotsControllerProvider>(
      builder: (context, provider, child) => Expanded(
        child: SearchAnchor.bar(
          viewHeaderHeight: 32,
          barLeading: Icon(
            Icons.search,
            size: 32,
            color: kRed,
          ),
          barBackgroundColor: const WidgetStatePropertyAll(kAlmostWhite),
          barHintText: "Pesquisar picos de rua",
          //Limpa o histórico de pesquisas ao fechar a search bar
          onClose: () => provider.picosPesquisados.clear(),
          // Ação ao submeter a pesquisa (pressionar enter)
          onSubmitted: (value) {
            if(provider.picosPesquisados.isNotEmpty) {
              widget.onTapSuggestion(provider.picosPesquisados.first);
            }
          },
          // Ação ao mudar o texto na search bar
          onChanged: (value) { 
            if(value.isNotEmpty){provider.pesquisandoPico(value);}
            value.isNotEmpty || provider.picosPesquisados.isEmpty ? emptyText = 'Nenhum resultado encontrado' : emptyText = 'Digite algo para pesquisar';
            if(value.isEmpty) {emptyText = 'Digite algo para pesquisar';}
          },
          suggestionsBuilder: (context, controllerSearch) {
            if(controllerSearch.text.isEmpty) {
              return [
                ListTile(
                  title: Text(emptyText),
                ),
              ];
            }
        
            if (provider.picosPesquisados.isEmpty) {
              return [
                ListTile(
                  title: Text(emptyText),
                ),
              ];
            }
        
            return provider.picosPesquisados.map((pico) {
              return ListTile(
                title: Text(pico.picoName),
                dense: true,
                leading: SizedBox(
                  width: 60,
                  height: 40,
                  child: Image.network(pico.imgUrls.first, fit: BoxFit.fill)),
                subtitle: Text(pico.tipoPico.selectedValue),
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
      ),
    );
  }
}
