import 'package:demopico/features/mapa/data/services/firebase_spots_service.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_spot_repository.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';

class CreateSpotUc {
  static CreateSpotUc? _createSpotUc;
  static CreateSpotUc get getInstance {
    _createSpotUc ??=
        CreateSpotUc(spotRepositoryIMP: FirebaseSpotsService.getInstance);
    return _createSpotUc!;
  }

  final ISpotRepository spotRepositoryIMP;

  CreateSpotUc({required this.spotRepositoryIMP});

  Future<PicoModel?> createSpot(PicoModel pico) async {
    try {
      final picoCriado = await spotRepositoryIMP.createSpot(pico);
      if (picoCriado != null) {
        return picoCriado;
      }
      throw Exception("Pico retornou null");
    } on Exception catch (e) {
      throw Exception("Erro ao criar piquerson: $e ");
    } catch (e) {
      throw Exception("Erro inesperado criar piquerson: $e ");
    }
  }
}
