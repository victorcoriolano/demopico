import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';
import 'package:demopico/features/mapa/data/models/pico_model.dart';

class AvaliarSpotUc {
  final ISpotRepository notaRepository;

  AvaliarSpotUc(this.notaRepository);

  Future<PicoModel> executar(double novaNota, PicoModel pico) async {
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
