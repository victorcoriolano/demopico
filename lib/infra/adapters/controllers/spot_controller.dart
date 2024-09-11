@ -1,32 +0,0 @@
import 'package:demopico/domain/usecases/create_spot.dart';
import 'package:demopico/domain/usecases/delete_spot.dart';
import 'package:demopico/domain/usecases/list_spot.dart';
import 'package:demopico/domain/usecases/update_spot.dart';

class SpotController {
  final CreateSpot createSpotUseCase;
  final DeleteSpot deleteSpotUseCase;
  final UpdateSpot updateSpotUseCase;
  final ListSpots listSpotsUseCase;

  SpotController(this.createSpotUseCase, this.deleteSpotUseCase,
      this.updateSpotUseCase, this.listSpotsUseCase);

  void createSpot(
      int id, String spotName, String description, int lat, int long) {
    createSpotUseCase.execute(id, spotName, description, lat, long);
  }

  void deleteSpot(int id) {
    deleteSpotUseCase.execute(id);
  }

  void updateSpot(
      int id, String spotName, String description, int lat, int long) {
    updateSpotUseCase.execute(id, spotName, description, lat, long);
  }

  void listSpots() {
    listSpotsUseCase.execute();
  }
}