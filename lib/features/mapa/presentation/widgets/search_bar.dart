import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_controller.dart';
import 'package:demopico/features/mapa/presentation/view_services/modal_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class SearchBarSpots extends StatefulWidget {
  const SearchBarSpots({super.key});

  @override
  State<SearchBarSpots> createState() => _SearchBarSpotsState();
}

class _SearchBarSpotsState extends State<SearchBarSpots> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SpotControllerProvider>(
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
                controllerSearch.closeView(pico.picoName);
                controllerSearch.clear();
                context
                    .read<MapControllerProvider>()
                    .reajustarCameraPosition(LatLng(pico.lat, pico.long));
                ModalHelper.openModalInfoPico(
                    context, pico, provider.deletarPico);
              },
            );
          }).toList();
        },
        viewBackgroundColor: kAlmostWhite,
      ),
    );
  }
}
