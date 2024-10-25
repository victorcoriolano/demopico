import 'package:demopico/features/mapa/presentation/controllers/add_pico_controller.dart';
import 'package:demopico/features/mapa/presentation/widgets/add_pico_modal/container_telas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPicoWidget extends StatefulWidget {
  const AddPicoWidget({
    super.key,
  });

  @override
  AddPicoWidgetState createState() => AddPicoWidgetState();
}

class AddPicoWidgetState extends State<AddPicoWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddPicoControllerProvider>(
      builder: (context, provider, child) => Stack(
        children: [
          if (_isExpanded)
            Stack(alignment: Alignment.topRight, children: [
              Center(
                child: ContainerTelas(
                  lat: provider.lat,
                  long: provider.long,
                  expanded: _isExpanded,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  iconSize: 36, // Cor branca para o botão "X"
                  onPressed: () {
                    setState(() {
                      _isExpanded =
                          !_isExpanded; // Alterna a exibição do widget
                    });
                  },
                ),
              ),
            ]),
          if (!_isExpanded)
            Positioned(
              bottom: 40.0,
              right: 20.0,
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(
                    color: const Color.fromARGB(255, 162, 162, 162),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 6,
                      shape: const CircleBorder(),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      setState(() {
                        _isExpanded =
                            !_isExpanded; // Alterna a exibição do widget
                      });
                    },
                    child: SizedBox.expand(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                              color: Color(0xFFBB271A),
                            ),
                            width: 44,
                            height: 8,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                              color: Color(0xFFBB271A),
                            ),
                            width: 8,
                            height: 44,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
