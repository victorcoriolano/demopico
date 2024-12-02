import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/spot_repository.dart';

class GetSaveSpot {
  final SpotRepository spotRepository;

  GetSaveSpot(this.spotRepository);

  Future<List<Pico>> executeUseCase(String idUser)async{
    try {
    final picsosSalvos =  await spotRepository.getSavePico(idUser);
    if(picsosSalvos.isNotEmpty){
    return picsosSalvos;
  } else{
    return [];
  }
} catch (e) {
  print("Erro na exception(pegar pico salvo): $e");
  return [];
}
    
  }

}