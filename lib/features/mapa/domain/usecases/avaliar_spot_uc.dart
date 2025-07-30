
import 'package:demopico/features/mapa/data/repositories/spot_repository_impl.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
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

  Future<void> executar(Pico pico, double newRating) async {
    return await notaRepositoryIMP.evaluateSpot(PicoModel.fromEntity(pico), newRating);
  }
  
}
