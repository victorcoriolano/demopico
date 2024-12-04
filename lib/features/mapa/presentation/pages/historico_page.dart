import 'package:demopico/features/mapa/presentation/controllers/historico_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart';
import 'package:demopico/features/mapa/presentation/pages/map_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HistoricoPage extends StatelessWidget {
  const HistoricoPage({super.key});

  void _verPicoNoMapa(BuildContext context, LatLng location) async {
    //final mapProvider = context.read<MapControllerProvider>();

    // Ajustar a câmera antes de navegar para a página do mapa.
    //mapProvider.reajustarCameraPosition(location);

    // Navegar para a página do mapa.
    Navigator.push(context, MaterialPageRoute(builder: (_) => const MapPage()));
  }
  @override
  Widget build(BuildContext context) {
    final controller = context.read<HistoricoController>();

  // Garante que o carregamento inicial só aconteça uma vez
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (!controller.isLoading && controller.historico.isEmpty) {
      controller.carregarHistoricoInicial();
    }
  });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Histórico"),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
              onPressed: () {
                _confirmarDeletarHistorico(context);
              },
              icon: const Icon(Icons.delete_forever)),
        ],
      ),
      body: Consumer<HistoricoController>(
  builder: (context, controller, _) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.historico.isEmpty) {
      return const Center(child: Text("Você não possui histórico"));
    }

    return ListView.builder(
      itemCount: controller.historico.length,
      itemBuilder: (context, index) {
        final name = controller.historico[index]["nome"];
        final lat = controller.historico[index]["latitude"];
        final long = controller.historico[index]["longitude"];
        return ListTile(
          title: Text(name),
          subtitle: Text("Localização: $lat - $long"),
          leading: IconButton(
            onPressed: () {
              _verPicoNoMapa(context, LatLng(lat, long));
            },
            icon: const Icon(Icons.map_outlined),
            tooltip: "Ver Pico no mapa",
          ),
          trailing: IconButton(
            onPressed: () async {
              await controller.apagarItem(name);
            },
            icon: const Icon(Icons.delete_outline),
            tooltip: "Deletar",
          ),
        );
      },
    );
  },
),

    );
  }
  
  Future<void> _confirmarDeletarHistorico(BuildContext context) {
    final controller = context.read<HistoricoController>();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Limpar Histórico"),
          content: const Text("Deseja realmente deletar o histórico?"),
          actions: [
            TextButton(
              onPressed: () async {
                await controller.limparHistorico();
                if(context.mounted){
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Limpar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }
}