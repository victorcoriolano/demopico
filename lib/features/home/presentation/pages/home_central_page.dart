import 'package:demopico/features/home/presentation/widgets/skatepico_logo.dart';
import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart';
import 'package:demopico/features/mapa/presentation/view_services/modal_helper.dart' show ModalHelper;
import 'package:demopico/features/mapa/presentation/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:provider/provider.dart';

class HomeCentralPage extends StatefulWidget {
  const HomeCentralPage({super.key});

  @override
  State<HomeCentralPage> createState() => _HomeCentralPageState();
}

class _HomeCentralPageState extends State<HomeCentralPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Expanded(
            child: Stack(
              children: [
                Positioned(bottom: 2, child: SkatePicoLogo()),
            
                Positioned(
                  bottom: 8,
                  child: SearchBarSpots(onTapSuggestion: (pico) {
                    context
                      .read<MapControllerProvider>()
                      .reajustarCameraPosition(LatLng(pico.location.latitude, pico.location.longitude));
                      ModalHelper.openModalInfoPico(
                      context, pico);
                  },
                )),
            
            
              ],
            ),
          ),
        )
      );
  }
}