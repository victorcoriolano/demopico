import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/spot_repository.dart';

class AvaliarSpot {
  final SpotRepository notaRepository;

  AvaliarSpot(this.notaRepository);

  Future<Pico> executar(double novaNota, Pico pico) async {
    double novaMedia;
    int novoTotalAvaliacoes;

    if (pico.numeroAvaliacoes == 0) {
      // Primeira avaliação
      novaMedia = novaNota;
      novoTotalAvaliacoes = 1;
    } else {
      // Atualiza média com base nas avaliações existentes
      novaMedia = ((pico.nota! * pico.numeroAvaliacoes!) + novaNota) /
          (pico.numeroAvaliacoes! + 1);
      novoTotalAvaliacoes = pico.numeroAvaliacoes! + 1;
    }

    // Atualizar no repositório
    pico.nota = novaMedia;
    pico.numeroAvaliacoes = novoTotalAvaliacoes;
    
    await notaRepository.salvarNota(pico);
    return pico;
  }
}