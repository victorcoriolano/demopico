import 'package:demopico/domain/entities/spot.dart';
import 'package:demopico/domain/repositories/spot_repository.dart';

class ListSpots {
  final SpotRepository spotRepository;

  ListSpots(this.spotRepository);

  Future<List<Spot>> execute() {
    return spotRepository.findAll();
  }
}
