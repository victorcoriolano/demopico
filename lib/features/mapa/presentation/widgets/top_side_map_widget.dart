import 'package:demopico/features/mapa/domain/entities/filters.dart';
import 'package:demopico/features/mapa/presentation/controllers/map_controller.dart';
import 'package:demopico/features/mapa/presentation/controllers/spots_controller.dart';
import 'package:demopico/features/mapa/presentation/view_services/modal_helper.dart';
import 'package:demopico/features/mapa/presentation/widgets/search_bar.dart';
import 'package:flutter/material.dart';
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


  @override
  Widget build(BuildContext context) {

    return Consumer<SpotsControllerProvider>(
      builder: (context, spotProvider, child) => AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        backgroundColor: const Color(0xFF8B0000),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(              
              child: SearchBarSpots(
                onTapSuggestion: (pico) {
                context
                    .read<MapControllerProvider>()
                    .reajustarCameraPosition(LatLng(pico.lat, pico.long));
                ModalHelper.openModalInfoPico(
                    context, pico);
              },
              ),
            ),
            const SizedBox(width: 10),
            PopupMenuButton<String>(
              icon: const Icon(Icons.filter_list, color: Colors.white),
              tooltip: "Filtrar picos",
              onSelected: (String? value) {
                if (value == "Modalidade"){
                  return;
                }
                if (value == 'Utilidades') {
                  mostrarAtributos(context);
                } else if (value == 'todos'){
                  
                  spotProvider.aplicarFiltro();
                } else{
                  Filters filterTipo = Filters(
                    tipo: value
                  );
                  spotProvider.aplicarFiltro(filterTipo);
                }
                
                
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
      ),
    );
  }
  
  Future<void> mostrarAtributos(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<SpotsControllerProvider>(
          builder: (BuildContext context, SpotsControllerProvider provider, Widget? child) => AlertDialog(
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
