import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_controller.dart';
import 'package:demopico/features/mapa/presentation/widgets/marker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class TopSideMapWidget extends StatelessWidget implements PreferredSizeWidget {
  const TopSideMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MapControllerProvider>(context, listen: false);
    final spotProvider =
        Provider.of<SpotControllerProvider>(context, listen: false);
    final _buscarController = TextEditingController();
    final Set<Marker> markers = spotProvider.markers;
    //final namesPico = markers

    void searchPico(String name) {
      try {
        final Marker? marker = markers.firstWhere(
          (marker) => marker.markerId.value == name,
          //orElse: () => null,
        );
        // Procurando o pico no provider para mostrar suas informações
        Pico? picoPesquisado =
            spotProvider.spots.firstWhere((pico) => name == pico.picoName);

        if (marker != null) {
          // Pega o controller do Provider e centraliza o mapa
          provider.reajustarCameraPosition(marker.position);
          showPicoModal(context, picoPesquisado);
        } else {
          print('Pico não encontrado');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Pico não encontrado"),
            ),
          );
        }
      } on Exception catch (e) {
        print(e);
      } catch (e) {
        print("Erro fudidassa: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
                "Erro ao procurar pico! Deseja procurar na lista de picos?"),
            action: SnackBarAction(label: "sim", onPressed: () {}),
          ),
        );
      }
    }
    void searchingPico(String word){
      word = word.toLowerCase();
      
    }

    return AppBar(
      automaticallyImplyLeading: false, // resolvendo bug de aparecer seta
      toolbarHeight: 100, // Ajuste a altura da AppBar se necessário
      backgroundColor: const Color(0xFF8B0000),
      title: Row(
        mainAxisAlignment:
            MainAxisAlignment.center, // Centraliza o conteúdo do Row
        children: [
          Expanded(
            child: SizedBox(
              height: 42, // Altura do campo de busca
              child: TextField(
                controller: _buscarController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10), // Centraliza o conteúdo verticalmente
                  hintText: 'Buscar Picos',
                  prefixIcon: IconButton(
                    // transformando em iconButton para execultar a lógica de pesquisar
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
          const SizedBox(
              width: 10), // Espaçamento entre a barra de busca e os ícones
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.filter_list,
              color: Colors.white,
            ),
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
                )),
              ];
            },
          ),
          /* IconButton(
          icon: Icon(Icons.settings, color: Colors.white,size: 30),
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        ), */
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
  Size get preferredSize => const Size.fromHeight(80);
}
