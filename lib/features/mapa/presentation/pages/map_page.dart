import 'package:demopico/features/mapa/presentation/widgets/add_pico_widget.dart';
import 'package:demopico/features/mapa/presentation/widgets/drawer_widget.dart';
import 'package:demopico/features/mapa/presentation/widgets/map_widget.dart';
import 'package:demopico/features/mapa/presentation/widgets/top_side_map_widget.dart';
import 'package:flutter/material.dart';


class MapPage extends StatelessWidget { // convertendo pra stl pq eh imutalvel 
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        appBar: TopSideMapWidget(), 
        body: const Stack(
          children: [
            MapWidget(),
            AddPicoWidget(),
          ],
        ),
        endDrawer: MyDrawer(),
      );
  }
}
