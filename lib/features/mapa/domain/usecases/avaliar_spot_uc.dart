
import 'package:demopico/features/mapa/data/repositories/spot_repository_impl.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';

class AvaliarSpotUc {

  static AvaliarSpotUc? _avaliarSpotUc;
     static AvaliarSpotUc  get getInstance{
    _avaliarSpotUc ??= AvaliarSpotUc(notaRepositoryIMP: SpotRepositoryImpl.getInstance);
    return _avaliarSpotUc!;
  } 


  final ISpotRepository notaRepositoryIMP;

  AvaliarSpotUc({required this.notaRepositoryIMP});

  Future<PicoModel> executar(double novaNota, PicoModel pico) async {
    double novaMedia;
    int novoTotalAvaliacoes;
    
    if (pico.numeroAvaliacoes == 0) {
      // Primeira avaliação
      novaMedia = novaNota;
      novoTotalAvaliacoes = 1;
    } else {
      // Atualiza média com base nas avaliações existentes
      novaMedia = ((pico.initialNota * pico.numeroAvaliacoes) + novaNota) /
          (pico.numeroAvaliacoes + 1);
      novoTotalAvaliacoes = pico.numeroAvaliacoes + 1;
    }

    // Atualizar no repositório
    pico.initialNota = novaMedia;
    pico.numeroAvaliacoes = novoTotalAvaliacoes;

    await notaRepositoryIMP.updateSpot(pico);
    return pico;
  }
  
}
