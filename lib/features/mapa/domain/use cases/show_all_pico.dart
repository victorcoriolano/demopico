import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/spot_repository.dart';

class ShowAllPico {
  final SpotRepository spotRepository;
  ShowAllPico(this.spotRepository);

    Future<List<Pico>> executa() async {
    // pegando o spot do banco de dados e transformando em um marker
    try {
      List<Pico> spots = await spotRepository.showAllPico();
      return spots;
    } catch (e) {
      print('Erro ao pegar spots: $e');
      return [];
    }
  }
}