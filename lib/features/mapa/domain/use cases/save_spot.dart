import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/spot_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SaveSpot {
  final SpotRepository spotRepository;
  SaveSpot(this.spotRepository);

  Future<bool> saveSpot(Pico pico, User user) async {
    try{
      await spotRepository.saveSpot(pico, user);
      return true;
    }catch (e){
      print(e);
      return false;
    }
  }

  Future<List<Pico>> executeUseCase(String idUser) async {
    try {
      final picsosSalvos = await spotRepository.getSavePico(idUser);
      print(picsosSalvos);
      if (picsosSalvos.isNotEmpty) {
        print("Deu bom: $picsosSalvos");
        return picsosSalvos;
        
      } else {
        print("Deu Ruim");
        return [];
      }
    } catch (e) {
      print("Erro na exception(pegar pico salvo): $e");
      return [];
    }
  }

  Future<void> deleteSaveSpot(String idUser, String namePico)async{
    try{
      await spotRepository.deleteSave(idUser, namePico);
      
    }catch (e){
      print("Erro ao deletar pico salvo: $e");
      
    }
  }
}