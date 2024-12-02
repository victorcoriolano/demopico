import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/interfaces/spot_repository.dart';
import 'package:demopico/features/user/data/models/loggeduser.dart';

class SaveSpot {
  final SpotRepository spotRepository;
  SaveSpot(this.spotRepository);

  Future<void> saveSpot(Pico pico, LoggedUserModel user) async {
    try{
      await spotRepository.saveSpot(pico, user);
    }catch (e){
      print(e);
    }

  }
}