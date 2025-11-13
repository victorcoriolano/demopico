import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ConfigMapaWidget extends StatelessWidget {
  const ConfigMapaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              const Text("Zoom do mapa"),
              Consumer<MapControllerProvider>(
                  builder: (context, provider, child) {
                return Slider(
                  min: 5.0,
                  max: 20.0,
                  value: provider.zoomInicial,
                  onChanged: (value) {
                    provider.setZoom(value);
                  },
                );
              }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Tipo do mapa"),
              Consumer<MapControllerProvider>(
                  builder: (context, provider, child) {
                return DropdownButton<MapType>(
                  value: provider.myMapType,
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
                    if (mapType != null) provider.setMapType(mapType);
                  },
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
