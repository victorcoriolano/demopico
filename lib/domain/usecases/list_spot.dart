import 'package:cleancode_poc/domain/entities/spot.dart';
import 'package:cleancode_poc/domain/repositories/spot_repository.dart';

class ListSpots {

  final SpotRepository spotRepository;

  ListSpots(this.spotRepository);

  Future<List<Spot>> execute() {
    return spotRepository.findAll();
  }
}