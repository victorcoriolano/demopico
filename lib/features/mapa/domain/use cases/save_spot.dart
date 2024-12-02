import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/spot_repository.dart';
import 'package:demopico/features/user/data/models/loggeduser.dart';

class SaveSpot {
  final SpotRepository spotRepository;
  SaveSpot(this.spotRepository);

  Future<bool> saveSpot(Pico pico, LoggedUserModel user) async {
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
      if (picsosSalvos.isNotEmpty) {
        return picsosSalvos;
      } else {
        return [];
      }
    } catch (e) {
      print("Erro na exception(pegar pico salvo): $e");
      return [];
    }
  }

  Future<bool> deleteSaveSpot(String idUser, String namePico)async{
    try{
      await spotRepository.deleteSave(idUser, namePico);
      return true;
    }catch (e){
      print("Erro ao deletar pico salvo: $e");
      return false;
    }
  }
}