import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/presentation/controllers/historico_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_modal/container_telas.dart';
import 'package:demopico/features/mapa/presentation/widgets/show_pico_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  static void openModalInfoPico(BuildContext context, Pico pico, void Function(Pico) onDelete) {
    debugPrint("chamou o modal para o pico ${pico.picoName}");
    // salvando no histórico
    final provider = context.read<HistoricoController>();
    provider.salvarNoHistorico(pico.picoName, pico.lat, pico.long);

    try {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent, // Transparência para o fundo
        builder: (context) {
          debugPrint("chamou o modal para o pico ${pico.picoName}");
              return ShowPicoWidget(
                deletarPico: onDelete,
                pico: pico,
              );
        },
      );
    } catch (e) {
      throw Exception('Erro ao abrir o modal: $e');
    }
  }

  static Future<void> abrirModalConfgMap(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<MapControllerProvider>(
          builder: (context, mapProvider, child) {
            return AlertDialog(
              title: const Text('Configure seu mapa'),
              content: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Zoom do mapa"),
                    Slider(
                      min: 5.0,
                      max: 20.0,
                      value: mapProvider
                          .zoomInicial, 
                      onChanged: (value) {
                        mapProvider.setZoom(value);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Tipo do mapa"),
                        DropdownButton<MapType>(
                          value: mapProvider
                              .myMapType, 
                          items: const [
                            DropdownMenuItem(
                                value: MapType.normal, child: Text("Normal")),
                            DropdownMenuItem(
                                value: MapType.satellite, child: Text("Satélite")),
                            DropdownMenuItem(
                                value: MapType.terrain, child: Text("Terreno")),
                            DropdownMenuItem(
                                value: MapType.hybrid, child: Text("Híbrido")),
                          ],
                          onChanged: (mapType) {
                            if (mapType != null) mapProvider.setMapType(mapType);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Fechar'),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            );
          }
        );
      },
    );
  }
}
