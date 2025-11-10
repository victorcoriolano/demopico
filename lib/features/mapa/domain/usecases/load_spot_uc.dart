import 'package:demopico/features/mapa/data/repositories/spot_repository_impl.dart';
import 'package:demopico/features/mapa/domain/entities/filters.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';

class LoadSpotUc {

  static LoadSpotUc? _loadSpotUc;

     static LoadSpotUc  get getInstance{
    _loadSpotUc ??= LoadSpotUc(spotRepositoryIMP: SpotRepositoryImpl.getInstance);
    return _loadSpotUc!;
  } 


  final ISpotRepository spotRepositoryIMP;
  LoadSpotUc({required this.spotRepositoryIMP});

  Stream<List<Pico>> loadSpots([Filters? filtros]) {
    final modelStream = spotRepositoryIMP.watchListSpots(filtros);
    return modelStream.asyncMap((listEvents) => listEvents.map((model) => model.toEntity()).toList());
  }
}