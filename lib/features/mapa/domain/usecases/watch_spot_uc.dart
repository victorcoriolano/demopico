
import 'package:demopico/features/mapa/data/repositories/spot_repository_impl.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';

class WatchSpotUc {

  static WatchSpotUc? _instance;
  static WatchSpotUc get instance{
    return _instance ??= WatchSpotUc(repository: SpotRepositoryImpl.getInstance);
  }

  final ISpotRepository _repository;

  WatchSpotUc({required ISpotRepository repository}): _repository = repository;

  Stream<Pico> execute(String idPico) => _repository.watchSpot(idPico);
}