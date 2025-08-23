import 'dart:async';

import 'package:demopico/features/mapa/domain/entities/filters.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/usecases/get_my_spots_uc.dart';
import 'package:demopico/features/mapa/domain/usecases/load_spot_uc.dart';
import 'package:demopico/features/mapa/presentation/view_services/marker_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SpotsControllerProvider extends ChangeNotifier {

  static SpotsControllerProvider? _spotControllerProvider;
  static SpotsControllerProvider get getInstance {
    _spotControllerProvider ??= SpotsControllerProvider(
        showAllPicoUseCase: LoadSpotUc.getInstance,
        getMySpotsUc: GetMySpotsUc.instance,);
    return _spotControllerProvider!;
  }

  SpotsControllerProvider(
    {
      required this.showAllPicoUseCase,
      required this.getMySpotsUc,
    });

  // use cases
  final LoadSpotUc showAllPicoUseCase;
  final GetMySpotsUc getMySpotsUc;


  // states
  List<Pico> spots = [];
  List<Pico> picosPesquisados = [];
  List<Pico> mySpots = [];
  Filters? filtrosAtivos;
  Set<Marker> markers = {};
  void Function(Pico)? _onTapMarker;
  bool isLoading = false;
  

  String? error;

  void setOnTapMarker(void Function(Pico) onTapMarker) {
    _onTapMarker = onTapMarker;
  }

  

  final MarkerService markerService = MarkerService.getInstance;

  StreamSubscription? spotsSubscription;

  //inicializa o controller carregando os spots do banco
  void initialize() {// passando o callback para o markerService
    debugPrint("initialize");
    _loadSpots();
  }

   

  //cria um stream para ouvir os spots do banco de dados
  void _loadSpots() {//repassando o callback para o markerService
    debugPrint("chamou loadSpots");
    spotsSubscription?.cancel();
    if (filtrosAtivos != null) {
      debugPrint("filtrosAtivos não é null");
      spotsSubscription =
        showAllPicoUseCase.loadSpots(filtrosAtivos).listen(
          (events) {
            spots.clear();
            spots.addAll(events);
            debugPrint("spots: ${spots.length}");
            carregarMarkers();
          },

          onError: (error) {
            debugPrint("error: $error");
          }
        );  
    }else {
      debugPrint("filtrosAtivos é null");
      spotsSubscription =
        showAllPicoUseCase.loadSpots().listen(
          (events) {
            spots.clear();
            spots.addAll(events);
            debugPrint("spots: ${spots.length}");
            carregarMarkers();
          },

          onError: (error) {
            debugPrint("error: $error");
          }
        );
    }
    
  }

  Future<void> carregarMarkers() async {//repassando o callback para o markerService
    if (_onTapMarker == null){
      debugPrint("onTapMarker não pode ser null");
      return;
    }
    markers.clear();
    
    markerService.preloadIcons(spots, _onTapMarker!).listen(
      (marker) {
        markers.add(marker);
        notifyListeners();
      },
      onError: (error) {
        debugPrint("error: $error");
      },
    );
    notifyListeners();
  }


  //aplica os filtros e reacria o stream com os novos filtros
  void aplicarFiltro([Filters? filtros]) {
    debugPrint("aplicarFiltro: filtros $filtros");
    filtrosAtivos = filtros;
    debugPrint("filtrosAtivos: $filtrosAtivos");
    _loadSpots();
  }

  //cancela a subscription da stream
  @override
  void dispose() {
    spotsSubscription?.cancel();
    super.dispose();
  }


  // Método para pesquisar picos
  void pesquisandoPico(String word) {
    if(spots.isEmpty){
      _loadSpots();
    }
    word = word.toLowerCase();
    picosPesquisados = spots
        .where((argument) =>
            argument.picoName.toLowerCase().contains(word.toLowerCase()))
        .toList();
    notifyListeners();
  }

  List<String> utilidades = [
    'Água',
    'Teto',
    'Banheiro',
    'Suave Arcadiar',
    'Público / Gratuito'
  ];

  Map<String, bool> utilidadeFiltrar = {
    'Água': false,
    'Teto': false,
    'Banheiro': false,
    'Suave Arcadiar': false,
    'Público / Gratuito': false
  };
  List<String> utilidadesSelecionadas = [];

  void selecionarUtilidade(String utilidade, bool? isSelected) {
    utilidadeFiltrar[utilidade] = isSelected!;
    notifyListeners();
  }


  Future<void> getMySpots(String idUser) async{
    isLoading = true;
    notifyListeners();
    try {
      mySpots = await getMySpotsUc.execute(idUser);
      debugPrint('MysposLength: ${mySpots.length}');
      isLoading = false;
      notifyListeners();
    } catch (e){
      error = e.toString();
      debugPrint(error);
      isLoading = false;
      notifyListeners();
    }
  }
}
