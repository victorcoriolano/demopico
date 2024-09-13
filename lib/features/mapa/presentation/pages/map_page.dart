import 'package:demopico/features/mapa/presentation/widgets/map_widget.dart';
import 'package:demopico/features/mapa/presentation/widgets/show_pico_widget.dart';
import 'package:demopico/features/mapa/presentation/widgets/top_side_map_widget.dart';
import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  bool _isPanelVisible = false; // Controla a visibilidade do painel

  // Função chamada quando um ponto no mapa é clicado
  void _onMapPointTapped() {
    setState(() {
      _isPanelVisible = true; // Exibe o painel ao clicar em um ponto
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: const TopSideMapWidget(),
      body: Stack(
        children: [
          MapWidget(),
          // Simulação do widget de mapa (substitua pelo widget real)
          GestureDetector(
            onTap: _onMapPointTapped, // Simula o clique no ponto do mapa
             
          ),

          // Painel arrastável (oculto até o clique no mapa)
          if (_isPanelVisible) const ShowPicoWidget()
        ],
      ),
    ));
  }
}
