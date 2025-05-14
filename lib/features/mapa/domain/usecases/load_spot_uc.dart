import 'package:demopico/features/mapa/data/services/firebase_spots_service.dart';
import 'package:demopico/features/mapa/domain/entities/filters.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';

class LoadSpotUc {

  static LoadSpotUc? _loadSpotUc;

     static LoadSpotUc  get getInstance{
    _loadSpotUc ??= LoadSpotUc(spotRepositoryIMP: FirebaseSpotsService.getInstance);
    return _loadSpotUc!;
  } 


  final ISpotRepository spotRepositoryIMP;
  LoadSpotUc({required this.spotRepositoryIMP});

  Stream<List<Pico>> loadSpots(Filters? filtros) {
    return spotRepositoryIMP.loadSpots(filtros);
  }
}