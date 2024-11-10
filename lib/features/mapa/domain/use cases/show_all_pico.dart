import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/spot_repository.dart';

class ShowAllPico {
  final SpotRepository spotRepository;
  ShowAllPico(this.spotRepository);

    Future<List<Pico>> executa() async {
    try {
      List<Pico> spots = await spotRepository.showAllPico();
      return spots;
    } catch (e) {
      print('Erro ao pegar spots: $e');
      return [];
    }
  }
}