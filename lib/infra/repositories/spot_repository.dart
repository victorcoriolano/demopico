import 'package:demopico/domain/entities/spot.dart';

abstract class ISpotRepository {
  Future<List<Spot>> findAll();
  Future<Spot?> findById(int id);
  void saveSpot(Spot spot);
  void updateSpots(Spot spot);
  void deleteSpot(int id);
}

class SpotRepository implements ISpotRepository {
  final List<Spot> yourSpots = [];

  @override
  Future<List<Spot>> findAll() async {
    if (yourSpots.isNotEmpty) {
      return yourSpots;
    } else {
      throw Exception('No spots found');
    }
  }

  @override
  Future<Spot?> findById(int id) async {
    return yourSpots.firstWhere((spot) => spot.id == id);
  }

  @override
  void saveSpot(Spot spot) async {
    final id = yourSpots.length + 1;
    final newSpot = Spot(
        id: id,
        spotName: spot.spotName,
        description: spot.description,
        lat: spot.lat,
        long: spot.long);
    yourSpots.add(newSpot);
  }

  @override
  void updateSpots(Spot spot) async {
    final index = yourSpots.indexWhere((spots) => spots.id == spot.id);
    if (index != -1) {
      yourSpots[index] = spot;
    }
  }

  @override
  void deleteSpot(int id) async {
    yourSpots.removeWhere((spot) => spot.id == id);
  }
}
