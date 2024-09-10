import 'package:cleancode_poc/domain/entities/spot.dart';
import 'package:cleancode_poc/domain/repositories/spot_repository.dart';

class UpdateSpot {

  final SpotRepository spotRepository;

  UpdateSpot(this.spotRepository);

  void execute(int id, String spotName, String description, int lat, int long) {
    final updatedSpot = Spot(
      id: id,
      spotName: spotName,
      description: description,
      lat: lat,
      long: long
    );
    spotRepository.updateSpots(updatedSpot);
  }
}