import 'package:demopico/core/domain/entities/pico_entity_dart';
import 'package:demopico/features/mapa/data/repositories/spot_repository.dart';

class ListSpots {
  final SpotRepository spotRepository;

  ListSpots(this.spotRepository);

  Future<List<Spot>> execute() {
    return spotRepository.findAll();
  }
}
