import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';
import 'package:demopico/features/mapa/data/models/pico_model.dart';

class CreateSpotUc {
  final ISpotRepository spotRepository;

  CreateSpotUc(this.spotRepository);

  Future<PicoModel?> createSpot(PicoModel pico) async {
    try {
      final picoCriado = await spotRepository.createSpot(pico);
      if(picoCriado != null){
        return picoCriado;
      }
      throw Exception("Pico retornou null");
    } on Exception catch (e) {
      rethrow;
    } catch (e) {
      throw Exception("Erro inesperado criar piquerson: $e ");
    }
  }
}