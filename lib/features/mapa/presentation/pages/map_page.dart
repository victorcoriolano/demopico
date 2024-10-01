import 'package:demopico/features/mapa/presentation/widgets/add_pico_widget.dart';
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
/*   final List<Pico>  picos = [
    Pico(
      0, 
      0, 
      long: 0, 
      lat: 0, 
      description: "Marreto neste pico desde dos 7 anos, foi nele que aprendi a pular gap e mandar flip",
      atributos:{ "Chão": 5, "Iluminação": 3.5, 'Policiamento': 4, 'Movimento': 2, 'KickOut': 5 },
      fotoPico: ['https://www.xtremespots.com/wp-content/uploads/2013/10/Skate-Boarding-in-East-Monroe-Gap.jpg'], 
      obstaculos: ['corrimão', 'miniramp'], 
      utilidades: ['agua', 'banheiro'], 
      userCreator: 'Marreta', 
      urlIdPico: 'urlIdPico', 
      picoName: 'picoName'),

      Pico(
      0, 
      0, 
      long: 0, 
      lat: 0, 
      description: "Marreto neste pico desde dos 7 anos, foi nele que aprendi a pular gap e mandar flip",
          atributos:{ "Chão": 5, "Iluminação": 3.5, 'Policiamento': 4, 'Movimento': 2, 'KickOut': 5 },
      fotoPico: ['https://www.xtremespots.com/wp-content/uploads/2013/10/Skate-Boarding-in-East-Monroe-Gap.jpg'], 
      obstaculos: ['corrimão', 'miniramp'], 
      utilidades: ['agua', 'banheiro'], 
      userCreator: , 
      urlIdPico: 'urlIdPico', 
      picoName: 'picoName'),

      Pico(
      0, 
      0, 
      long: 0, 
      lat: 0, 
      description: "Marreto neste pico desde dos 7 anos, foi nele que aprendi a pular gap e mandar flip",
          atributos:{ "Chão": 5, "Iluminação": 3.5, 'Policiamento': 4, 'Movimento': 2, 'KickOut': 5 },
      fotoPico: ['https://www.xtremespots.com/wp-content/uploads/2013/10/Skate-Boarding-in-East-Monroe-Gap.jpg'], 
      obstaculos: ['corrimão', 'miniramp'], 
      utilidades: ['agua', 'banheiro'], 
      userCreator: , 
      urlIdPico: 'urlIdPico', 
      picoName: 'picoName'),

      Pico(
      0, 
      0, 
      long: 0, 
      lat: 0, 
      description: "Marreto neste pico desde dos 7 anos, foi nele que aprendi a pular gap e mandar flip",
          atributos:{ "Chão": 5, "Iluminação": 3.5, 'Policiamento': 4, 'Movimento': 2, 'KickOut': 5 },
      fotoPico: ['https://www.xtremespots.com/wp-content/uploads/2013/10/Skate-Boarding-in-East-Monroe-Gap.jpg'], 
      obstaculos: ['corrimão', 'miniramp'], 
      utilidades: ['agua', 'banheiro'], 
      userCreator: , 
      urlIdPico: 'urlIdPico', 
      picoName: 'picoName'),
      ];  */
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
            child: const MapWidget(
              markers: [],
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
