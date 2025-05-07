import 'package:demopico/features/mapa/domain/entities/pico_favorito.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_favorite_spot_repository.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';
import 'package:demopico/features/mapa/presentation/dtos/spot_cart_ui.dart';

class SaveSpotUc {
  final IFavoriteSpotRepository spotFavRepository;
  final ISpotRepository spotRepository;
  SaveSpotUc(this.spotRepository, this.spotFavRepository);

  Future<bool> saveSpot(PicoFavorito picoFav) async {
      try {
        await spotFavRepository.saveSpot(picoFav);
        return true;
      } catch (e) {
        print(e);
        return false;
      }
  }
  

  Future<List<SpotCardUIDto>> listFavoriteSpot(String idUser) async {
      
      try {
        final favoritos = await spotFavRepository.listFavoriteSpot(idUser);
        if(favoritos.isEmpty){
          throw Exception("Picos salvos não encontrados");
        }
        final result = await Future.wait(favoritos.map((fav) async {
          final pico = await spotRepository.getPicoByID(fav.id); // retorna PicoModel
          var card = SpotCardUIDto(picoFavoritoModel: fav, picoModel: pico);
          return card;
        }));
        return result;
       
      } catch (e) {
        print("Erro na exception(pegar pico salvo): $e");
        return [];
      }
  }

  Future<void> deleteSaveSpot(String idPicoFavModel)async{
    try{
      await spotFavRepository.deleteSave(idPicoFavModel);
      
    }catch (e){
      print("Erro ao deletar pico salvo: $e");
      
    }
  }
}