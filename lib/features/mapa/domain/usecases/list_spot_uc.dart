import 'package:demopico/features/mapa/data/models/pico_model.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';

class ListSpotUc {
  final ISpotRepository spotRepository;
  ListSpotUc(this.spotRepository);

    Future<List<Pico>> executa() async {
    try {
      List<PicoModel> spotsModel =  await spotRepository.showAllPico();
      List<Pico> spots = spotsModel.cast<Pico>();
      return spots;
    } catch (e) {
      print('Erro ao pegar spots: $e');
      return [];
    }
  }
}