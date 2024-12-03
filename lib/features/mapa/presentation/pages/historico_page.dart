import 'package:demopico/features/mapa/presentation/controllers/historico_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoricoPage extends StatelessWidget {
  const HistoricoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HistoricoController>();
    return Scaffold(
      
      appBar: AppBar(
        title: const Text("Histórico"),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: () {
              _confirmarDeletarHistorico(context);
            }, 
            icon: const Icon(Icons.delete_forever)
          ),
        ],
      ),
      body: controller.isLoading 
        ? const CircularProgressIndicator()
        : ListView.builder(
          itemCount: controller.historico.length,
          itemBuilder: (context, index) {
            final name = controller.historico[index]["nome"];
            final lat = controller.historico[index]["latitude"];
            final long = controller.historico[index]["longitude"];
            return ListTile(
              title: Text(name),
              subtitle: Text(
                "Localização: $lat - $long"
              ),
              leading: IconButton(
                onPressed: () {}, 
                icon: const Icon(Icons.map_outlined),
                tooltip: "Ver Pico no mapa",
              ),
              trailing: IconButton(
                onPressed: () {
                  controller.apagarItem(name);
                }, 
                icon: const Icon(Icons.delete_outline),
                tooltip: "Deletar",
              ),
            );
          }
        ),
    );
  }
  
  Future<void> _confirmarDeletarHistorico(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Limpar Histórico"),
          content: const Text("Deseja realmente deletar o histórico?"),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text("Limpar"),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }
}