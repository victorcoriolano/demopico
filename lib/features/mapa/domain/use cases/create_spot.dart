import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/spot_repository.dart';

class CreateSpot {
  final SpotRepository spotRepository;

  CreateSpot(this.spotRepository);
  Future<void> createSpot(Pico pico) async {
    await spotRepository.createSpot(pico);
  }

}