import 'package:demopico/domain/repositories/spot_repository.dart';

class DeleteSpot {
  final SpotRepository spotRepository;

  DeleteSpot(this.spotRepository);

  void execute(int id) {
    spotRepository.deleteSpot(id);
  }
}
