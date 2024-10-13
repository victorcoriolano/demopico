import 'package:demopico/core/common/inject_dependencies.dart';
import 'package:demopico/features/mapa/presentation/controllers/add_pico_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_controller.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_widget.dart';
import 'package:demopico/features/mapa/presentation/widgets/map_widget.dart';
import 'package:demopico/features/mapa/presentation/widgets/top_side_map_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MapPage extends StatelessWidget { // convertendo pra stl pq eh imutalvel 
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => serviceLocator<SpotControllerProvider>()),
        ChangeNotifierProvider(create: (_) => AddPicoControllerProvider()),
      ],
      child: const Scaffold(
        appBar: TopSideMapWidget(),
        body: Stack(
          children: [
            MapWidget(),
            AddPicoWidget(),
          ],
        ),
      ),
    );
  }
}
