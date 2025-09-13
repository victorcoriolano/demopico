import 'package:demopico/features/mapa/presentation/widgets/button_add_pico.dart';
import 'package:demopico/features/mapa/presentation/widgets/drawer_widget.dart';
import 'package:demopico/features/mapa/presentation/widgets/map_widget.dart';
import 'package:demopico/features/mapa/presentation/widgets/top_side_map_widget.dart';
import 'package:flutter/material.dart';


class MapPage extends StatelessWidget { 
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      const Scaffold(
        appBar: TopSideMapWidget(), 
        body: Stack(
          children: [
            MapWidget(),
            ButtonAddPico(),
          ],
        ),
        endDrawer: MyDrawer(),
      );
  }
}
