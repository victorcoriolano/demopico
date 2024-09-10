import 'package:cleancode_poc/domain/entities/spot.dart';
import 'package:cleancode_poc/domain/repositories/spot_repository.dart';

class CreateSpot {
  final SpotRepository spotRepository;

  CreateSpot(this.spotRepository);

  void execute(int id, String spotName, String description, int lat, int long) {
    final newSpot = Spot(
      id: 0, 
      spotName: spotName, 
      description: description, 
      lat: lat,
      long: long
    );
    spotRepository.saveSpot(newSpot);
  }
}