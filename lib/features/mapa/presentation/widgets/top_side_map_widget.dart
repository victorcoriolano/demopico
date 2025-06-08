import 'package:demopico/features/mapa/domain/entities/filters.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/spot_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';


class TopSideMapWidget extends StatefulWidget implements PreferredSizeWidget {
  const TopSideMapWidget({super.key});

  @override
  State<TopSideMapWidget> createState() {
    return _TopSideMapWidgetState();
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _TopSideMapWidgetState extends State<TopSideMapWidget> {
  final TextEditingController _buscarController = TextEditingController();
  OverlayEntry? overlayEntry;

  void showPicosOverlay(BuildContext context, List<Pico> picosPesquisados) {
    // Remove o overlay anterior, se ainda estiver ativo
    overlayEntry?.remove();

    if (picosPesquisados.isEmpty) {overlayEntry?.remove(); return;}

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
                    encontrouPico(pico.picoName);
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

  void removeOverlay(){
    overlayEntry?.remove();
    overlayEntry?.dispose();
    overlayEntry = null;
  }

  @override
  void dispose() {
    removeOverlay();
    _buscarController.dispose();
    super.dispose();
  }

  void encontrouPico(String namePico) {
    
    final provider = Provider.of<SpotControllerProvider>(context, listen: false);
    final controller = Provider.of<MapControllerProvider>(context, listen: false);
    Marker? markerEncontrado = provider.markers
        .toList()
        .firstWhereOrNull((markers) => markers.markerId.value.toLowerCase() == namePico.toLowerCase());
    if (markerEncontrado != null) {
      removeOverlay();
      controller.reajustarCameraPosition(markerEncontrado.position);
      
    } else {
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Pico não encontrado"),
        ),
      );
      removeOverlay();
    }
    _buscarController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final spotProvider = Provider.of<SpotControllerProvider>(context, listen: true);
    List<Pico> picos = spotProvider.picosPesquisados;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Exibe ou atualiza o overlay com a lista de picos pesquisados
      showPicosOverlay(context, picos);
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
              child: TextFormField(
                onChanged: (value) {
                  spotProvider.pesquisandoPico(value);
                },
                onFieldSubmitted: (value) => encontrouPico(value),
                
                controller: _buscarController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  hintText: 'Buscar Picos',
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search, color: Colors.grey),
                    onPressed: () {
                      final picoName = _buscarController.text.toString();
                      encontrouPico(picoName);
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
            tooltip: "Filtrar picos",
            onSelected: (String? value) {
              if (value == 'Utilidades') {
                mostrarAtributos(context);
              } else if (value == 'Modalidade') {
              } else if (value == 'todos'){
                debugPrint("Todos");
                spotProvider.aplicarFiltro();
              } 
              
              Filters filterTipo = Filters(
                tipo: value
              );
              spotProvider.aplicarFiltro(filterTipo);
            },
            color: Colors.white,
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'todos',
                  child: ListTile(
                    leading: Icon(Icons.podcasts),
                    title: Text("Mostrar todos"),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'SkatePark',
                  child: ListTile(
                    leading: Icon(Icons.skateboarding),
                    title: Text("Filtrar por SkatePark"),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Pico de Rua',
                  child: ListTile(
                    leading: Icon(Icons.terrain),
                    title: Text("Filtrar por Pico de rua"),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Half',
                  child: ListTile(
                    leading: Icon(Icons.auto_graph),
                    title: Text("Filtrar por Half"),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Bowl',
                  child: ListTile(
                    leading: Icon(Icons.bubble_chart_rounded),
                    title: Text("Filtrar por Bowl"),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'Street',
                  child: ListTile(
                    leading: Icon(Icons.location_city),
                    title: Text("Filtrar por Street"),
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: 'Utilidades',
                  child: ListTile(
                    title: Text("Filtrar por Utilidades"),
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem(
                  value: "Modalidade",
                  child: DropdownMenu(
                    hintText: 'Modalidade',
                    onSelected: (value) {
                      Filters filterModalidade = Filters(
                        modalidade: value
                      );
                      spotProvider.aplicarFiltro(filterModalidade);
                    },
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: 'Skate', label: 'Skate'),
                      DropdownMenuEntry(value: 'Parkuor', label: 'Parkuor'),
                      DropdownMenuEntry(value: 'BMX', label: 'BMX'),
                    ],
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
  
  Future<void> mostrarAtributos(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<SpotControllerProvider>(
          builder: (BuildContext context, SpotControllerProvider provider, Widget? child) => AlertDialog(
            title: const Text("Selecione as Utilidades"),
            content: Column(
              children: provider.utilidades.map((utilidade) {
                return CheckboxListTile(
                  title: Text(utilidade),
                  value: provider.utilidadeFiltrar[utilidade], 
                  onChanged: (bool? value) { 
                    provider.selecionarUtilidade(utilidade, value);
                    if(value == true){
                      provider.utilidadesSelecionadas.add(utilidade);
                    }else{
                      provider.utilidadesSelecionadas.remove(utilidade);
                    }
                  },
                );
              }).toList(),
            ),
            actions: [
              TextButton(
                onPressed: (){
                  var filtro = Filters(
                    utilidades: provider.utilidadesSelecionadas
                  );
                  provider.aplicarFiltro(filtro);
                  Navigator.pop(context);
                }, 
                child: const Text("Filtrar"),
              ),
            ],
          ), 
        );
      },
    );
  }
}
