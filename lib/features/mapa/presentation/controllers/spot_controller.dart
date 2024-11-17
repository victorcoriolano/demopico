import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/use%20cases/create_spot.dart';
import 'package:demopico/features/mapa/domain/use%20cases/show_all_pico.dart';
import 'package:demopico/features/mapa/presentation/widgets/marker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SpotControllerProvider extends ChangeNotifier {
  final CreateSpot createSpotUseCase;
  final ShowAllPico showAllPicoUseCase;

  Set<Marker> markers = {}; //lista vazia de markers para adicionar os picos
  List<Pico> spots = [];
  List<Pico> picosPesquisados = [];
  Marker? markerEncontrado;

  SpotControllerProvider(this.createSpotUseCase, this.showAllPicoUseCase);

  //método para chamar o caso de uso criar pico que irá execultar a lógica de criar o pico
  Future<void> createSpot(Pico pico, BuildContext context) async {
    final marker = picoMarker(pico, context);
    markers.add(marker);
    notifyListeners();
    try {
      await createSpotUseCase.createSpot(pico);
    } catch (e) {
      print('Erro ao criar pico: $e');
    }
    //chama a função de apresentar pico para atualizar a tela com o novo pico
  }

  //Mostrar picos na tela com base no use case
  Future<void> showAllPico(BuildContext context) async {
    try {
      spots = await showAllPicoUseCase.executa();
      markers = spots.map((spot) => picoMarker(spot, context)).toSet();
      notifyListeners();
    } catch (e) {
      print('Errilhos ao carregar markers: $e');
    }
  }

  //Método pra pesquisar pico
  void pesquisandoPico(String word) {
    word = word.toLowerCase();
    picosPesquisados = spots
        .where((argument) => argument.picoName.toLowerCase().contains(word.toLowerCase()))
        .toList();
    print("Ó os pico aq ó : $picosPesquisados");
    notifyListeners();
  }


/*   Métodos para filtrar */
  List<Pico> picosFiltrados = [];
  String? tipoSelecionado;

  void filtrarPicosPorTipo(String? tipo, BuildContext context) {
    tipoSelecionado = tipo;
    

    // Filtra os picos com base no tipo selecionado
    picosFiltrados = tipo == null
        ? spots // Exibe todos os spots se o tipo for nulo
        : spots.where((pico) => pico.tipoPico == tipo).toList();

    // Atualiza os markers apenas com os filtrados
    markers = picosFiltrados.map((pico) => picoMarker(pico, context)).toSet();
    notifyListeners();
  }
  List<String> utilidadeFiltrar = ['Água', 'Teto', 'Banheiro', 'Suave Arcadiar', 'Público / Gratuito'];
  List<String> utilidadesSelecionadas = [];

  void filtrarPorUtilidade(List<String>? utilidades, BuildContext context){
    picosFiltrados = utilidades == null 
      ? spots
      : spots.where((pico) => pico.utilidades!.contains(utilidades)).toList();
    
    markers = picosFiltrados.map((pico) => picoMarker(pico, context)).toSet();
    notifyListeners();
  }

  void adicionarUtilidade(String utilidade){
    utilidadesSelecionadas.add(utilidade);
  }
  
  void removerUtilidades(String utilidade){
    utilidadesSelecionadas.remove(utilidade);
  }
}
