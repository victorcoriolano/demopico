import 'package:demopico/features/mapa/domain/models/pico_model.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_save_spot_repository.dart';
import 'package:demopico/features/user/data/models/user.dart';

class SaveSpotUc {
  final IFavoriteSpotRepository spotRepository;
  SaveSpotUc(this.spotRepository);

  Future<bool> saveSpot(Pico pico, UserM? user) async {
    if (user != null) {
      try {
        
        await spotRepository.saveSpot(pico as PicoModel, user);
        return true;
      } catch (e) {
        print(e);
        return false;
      }
    } else {
      print("Usuário não encontrado");
      return false;
    }
  }
  

  Future<List<Pico>> listPicoUC(String? idUser) async {
    if (idUser != null) {
      try {
        final picsosSalvos = await spotRepository.listSavePico(idUser);
        if(picsosSalvos.isEmpty){
          return [];
        }
        return picsosSalvos;
      } catch (e) {
        print("Erro na exception(pegar pico salvo): $e");
        return [];
      }
    } else {
      print("Id do usuário não encontrado");
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