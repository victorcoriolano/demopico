import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_controller.dart';
import 'package:demopico/features/mapa/presentation/widgets/marker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';


class TopSideMapWidget extends StatefulWidget implements PreferredSizeWidget {
  const TopSideMapWidget({super.key});

  @override
  _TopSideMapWidgetState createState() => _TopSideMapWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _TopSideMapWidgetState extends State<TopSideMapWidget> {
  final TextEditingController _buscarController = TextEditingController();
  OverlayEntry? overlayEntry;

  void showPicosOverlay(BuildContext context, List<Pico> picosPesquisados) {
    // Remove o overlay anterior, se ainda estiver ativo
    overlayEntry?.remove();

    if (picosPesquisados.isEmpty) {overlayEntry?.remove(); return;};

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 100,
        left: 20,
        right: 20,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              itemCount: picosPesquisados.length,
              itemBuilder: (context, index) {
                final pico = picosPesquisados[index];
                return ListTile(
                  title: Text(pico.picoName),
                  onTap: () {
                    searchPico(pico.picoName);
                    overlayEntry?.remove(); // Fecha o overlay ao selecionar um pico
                    return;
                  },
                );
              },
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  void searchPico(String name) {
    final spotProvider = Provider.of<SpotControllerProvider>(context, listen: true);
    final provider = Provider.of<MapControllerProvider>(context, listen: true);

    try {
      spotProvider.pesquisandoPico(name);

      if (spotProvider.encontrouPico(name)) {
        Marker markerEncontrado = spotProvider.markerEncontrado!;
        provider.reajustarCameraPosition(markerEncontrado.position);
        showPicoModal(
          context,
          spotProvider.picosPesquisados.firstWhere(
            (pico) => pico.picoName == markerEncontrado.markerId.value,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Pico não encontrado"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              "Erro ao procurar pico! Deseja procurar na lista de picos?"),
          action: SnackBarAction(label: "sim", onPressed: () {}),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final spotProvider = Provider.of<SpotControllerProvider>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Exibe ou atualiza o overlay com a lista de picos pesquisados
      showPicosOverlay(context, spotProvider.picosPesquisados);
    });

    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 100,
      backgroundColor: const Color(0xFF8B0000),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: 42,
              child: TextField(
                onChanged: (value) {
                  spotProvider.pesquisandoPico(value);
                },
                onSubmitted: (value) => searchPico(value),
                controller: _buscarController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  hintText: 'Buscar Picos',
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search, color: Colors.grey),
                    onPressed: () {
                      final picoName = _buscarController.text.toString();
                      searchPico(picoName);
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            tooltip: "Filtrar por proximidade",
            onSelected: (String value) {},
            color: Colors.white,
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'proximidade',
                  child: ListTile(
                    leading: Icon(Icons.podcasts),
                    title: Text("Filtrar por proximidade"),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'pista',
                  child: ListTile(
                    leading: Icon(Icons.skateboarding),
                    title: Text("Filtrar por pista"),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'pico',
                  child: ListTile(
                    leading: Icon(Icons.terrain),
                    title: Text("Filtrar por pico"),
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text("Filtrar por atributos"),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.settings, color: Colors.white, size: 30),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    overlayEntry?.remove();
    _buscarController.dispose();
    super.dispose();
  }
}
