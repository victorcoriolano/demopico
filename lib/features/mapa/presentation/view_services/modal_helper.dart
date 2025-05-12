import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/presentation/controllers/historico_controller.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_modal/container_telas.dart';
import 'package:demopico/features/mapa/presentation/widgets/show_pico_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ModalHelper {
  static void openAddPicoModal(BuildContext context, LatLng latLng) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.868,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            ContainerTelas(
              expanded: false,
              latlang: latLng,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                iconSize: 36,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void openModalInfoPico(BuildContext context, Pico pico) {
    // salvando no histórico
    final provider = context.read<HistoricoController>();
    provider.salvarNoHistorico(pico.picoName, pico.lat, pico.long);

    try {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent, // Transparência para o fundo
        builder: (context) {
          return DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.2,
            maxChildSize: 0.86,
            builder: (BuildContext context, ScrollController scrollController) {
              return ShowPicoWidget(
                pico: pico,
              );
            },
          );
        },
      );
    } catch (e) {
      throw Exception('Erro ao abrir o modal: $e');
    }
  }
}
