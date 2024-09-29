import 'package:demopico/features/mapa/domain/entities/marker_maps_entity.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_widget.dart';
import 'package:demopico/features/mapa/presentation/widgets/map_widget.dart';
import 'package:demopico/features/mapa/presentation/widgets/show_pico_widget.dart';
import 'package:demopico/features/mapa/presentation/widgets/top_side_map_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    return Scaffold(
      appBar: const TopSideMapWidget(),
      body: Stack(
        children: [
          // Widget de mapa com marcadores
          GestureDetector(
            onTap: _onMapPointTapped, // Detecta o clique no ponto do mapa
            child: MapWidget(
              markers: [
                MarkerData(
                  id: '1',
                  position: LatLng(37.7749, -122.4194),
          
                ),
                MarkerData(
                  id: '2',
                  position: LatLng(37.8949, -122.4194),
                ),
              ],
            ),
          ),
          // Widget para adicionar um "pico" (local)
          const AddPicoWidget(),

          // Painel arrastável que aparece ao clicar no mapa
          if (_isPanelVisible) const ShowPicoWidget(),
        ],
      ),
    );
  }
}
