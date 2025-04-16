import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';
import 'package:demopico/features/mapa/data/models/pico_model.dart';

class CreateSpotUc {
  final ISpotRepository spotRepository;

  CreateSpotUc(this.spotRepository);
  Future<bool> createSpot(PicoModel pico) async {
    try {
      await spotRepository.createSpot(pico);
      return true;
    } on Exception catch (e) {
      print('Erro ao criar pico: $e');
      return false;
    } catch (e) {
      print('Erro ao criar desconhecido: $e');
      return false;
    }
  }

}