import 'package:demopico/app/home_page.dart';
import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_save_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  Future<void> abrirModalPicosSalvos(BuildContext context) {
    return showDialog(

      context: context,
      builder: (BuildContext context) {
        return Consumer<SpotSaveController>(
          builder: (context, provider, child) => AlertDialog(
            title: const Text('Seus picos Salvos'),
            content: Center(
              child: ListView.builder(
                itemCount: provider.picosSalvos.length,
                itemBuilder: (context, index) => Text(provider.picosSalvos[index].picoName),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Fechar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.all(16.0), // Espaçamento interno do menu
        color: Colors.white, // Cor de fundo do Drawer
        child: ListView(
          padding: EdgeInsets.zero, // Remove o padding padrão
          children: [
            // Botão Configurar Mapa
            MenuItem(
              icon: Icons.map, // Ícone para Configurar Mapa
              text: 'CONFIGURAR MAPA', // Texto do botão
              onPressed: () {
                // Ação ao clicar (adicione a funcionalidade necessária)
                Navigator.of(context).pop(); // Fecha o Drawer
                abrirModalConfgMap(context);
              },
            ),
            // Botão Picos Salvos
            MenuItem(
              icon: Icons.bookmark, // Ícone para Picos Salvos
              text: 'PICOS SALVOS', // Texto do botão
              onPressed: () {
                // Ação ao clicar (adicione a funcionalidade necessária)
                Navigator.of(context).pop(); // Fecha o Drawer
              },
            ),
            // Botão Histórico
            MenuItem(
              icon: Icons.history, // Ícone para Histórico
              text: 'HISTÓRICO', // Texto do botão
              onPressed: () {
                // Ação ao clicar (adicione a funcionalidade necessária)
                Navigator.of(context).pop(); // Fecha o Drawer
              },
            ),
            // Botão Home
            MenuItem(
              icon: Icons.home, // Ícone para Home
              text: 'HOME', // Texto do botão
              onPressed: () {
                // Navega de volta para a tela inicial
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> abrirModalConfgMap(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<MapControllerProvider>(
          builder: (context, mapProvider, child) => AlertDialog(
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
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon; // Ícone do item
  final String text; // Texto do item
  final VoidCallback onPressed; // Função a ser chamada ao pressionar o item

  // Construtor do MenuItem
  const MenuItem({super.key, 
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF8B0000)), // Ícone do item
      title: Text(text,
          style:
              const TextStyle(color: Colors.black)), // Texto do item em preto
      onTap: onPressed, // Ação a ser realizada ao pressionar o item
    );
  }
}
