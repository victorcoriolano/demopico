import 'package:demopico/features/denunciar/denuncia_model.dart';
import 'package:demopico/features/denunciar/widgets/denunciar_widget.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/presentation/controllers/historico_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_provider.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_modal/container_telas.dart';
import 'package:demopico/features/mapa/presentation/widgets/config_mapa_widget.dart';
import 'package:demopico/features/mapa/presentation/widgets/show_pico_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ModalHelper{
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

  static void openModalInfoPico(
      BuildContext context, Pico pico, ) {
    debugPrint("chamou o modal para o pico ${pico.picoName}");
    // salvando no histórico
    final provider = context.read<HistoricoController>();
    provider.salvarNoHistorico(pico.picoName, pico.location.latitude, pico.location.longitude);

    try {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent, // Transparência para o fundo
        builder: (context) {
          debugPrint("chamou o modal para o pico ${pico.picoName}");
          context.read<SpotProvider>().setPico(pico);
          return ShowPicoWidget(
            idPico: pico.id,
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
            content: ConfigMapaWidget(),
            actions: <Widget>[
              TextButton(
                child: const Text('Fechar'),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          );
        });
      },
    );
  }

  static Future<void> openModalDeleteSpot(BuildContext context, Pico pico) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir Pico'),
          content: const Text('Tem certeza que deseja excluir este pico?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                await context.read<SpotProvider>().deletarPico(pico);
                if(context.mounted) Navigator.pop(context);
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  static Future<void> openReportSpotModal(BuildContext context, String? idUser, String  idPub, TypePublication type){
    return showDialog(
      context: context,
      builder: (context) => DenunciaDialog(
        idUser: idUser, // Substituir pelo ID do usuário logado
        typePublication: type, // Tipo de publicação
        idPub: idPub,
      ),
    );
  }

  static Future<void> openRateSpotModal(BuildContext context, Pico pico){
    return showDialog(
      context: context,
      builder: (context) {
          return Consumer<SpotProvider>(
            builder: (context, provider, child) {
              return AlertDialog(
                title: const Text("AVALIAR PICO"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(provider.classification.name),
                    const SizedBox(height: 10),
                    RatingBar.builder(
                      
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        provider.updateClassification(rating);
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancelar"),
                  ),
                  TextButton(
                    onPressed: () async {
                      await provider.avaliarSpot();
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Avaliar"),
                  ),
                ],
              );
            }
          );
      },
    );
  }
}
