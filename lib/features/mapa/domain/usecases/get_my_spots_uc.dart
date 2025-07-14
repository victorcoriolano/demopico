import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';

class GetMySpotsUc {
  final ISpotRepository _spotRepository;

  GetMySpotsUc({required ISpotRepository repository}): _spotRepository = repository;

  Future<List<Pico>> execute(String userID) async {
    return await _spotRepository.getMySpot(userID);  
  }
}