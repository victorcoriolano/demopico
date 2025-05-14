import 'package:demopico/features/mapa/domain/entities/filters.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';

class LoadSpotUc {
  final ISpotRepository spotRepository;
  LoadSpotUc(this.spotRepository);

  Stream<List<Pico>> loadSpots(Filters? filtros) {
    return spotRepository.loadSpots(filtros);
  }
}