import 'package:demopico/features/mapa/data/repositories/spot_repository_impl.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';

class GetMySpotsUc {
  final ISpotRepository _spotRepository;

  GetMySpotsUc({required ISpotRepository repository}): _spotRepository = repository;

  static GetMySpotsUc? _instance;
  static GetMySpotsUc get instance => _instance ?? GetMySpotsUc(repository: SpotRepositoryImpl.getInstance);

  Future<List<Pico>> execute(String userID) async {
    final models = await _spotRepository.getMySpots(userID);
    return models.map((model) => model.toEntity()).toList();  
  }
}