import 'package:demopico/features/mapa/presentation/widgets/add_pico_modal/container_telas.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddPicoWidget extends StatefulWidget {
  final LatLng argument;
  const AddPicoWidget({super.key, required this.argument});
  
  @override
  AddPicoWidgetState createState() => AddPicoWidgetState();
}

class AddPicoWidgetState extends State<AddPicoWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_isExpanded)
          GestureDetector(
            onTap: () {
              // Fecha o container quando clicar fora
              setState(() {
                _isExpanded = false;
              });
            },
            child: Container(
              color: Colors.transparent, // Permite detectar cliques fora
              child: Center(
                child: ContainerTelas(
                  lat: widget.argument.latitude, 
                  long: widget.argument.longitude,
                ),
              ),
            ),
          ),
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
                      _isExpanded = !_isExpanded; // Alterna a exibição do widget
                    });
                  },
                  child: SizedBox.expand(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16.0)),
                            color: Color(0xFFBB271A),
                          ),
                          width: 44,
                          height: 8,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16.0)),
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
    );
  }
}
