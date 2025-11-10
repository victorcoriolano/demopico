import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/models/pico_favorito_model.dart';

class SpotCardUIDto {
  Pico pico;
  PicoFavoritoModel picoFavoritoModel;

  SpotCardUIDto({
    required this.pico,
    required this.picoFavoritoModel,
  });

  @override
  String toString() {
    return "Pico: ${pico.picoName} - Favorito: ${picoFavoritoModel.idPico}";
  }
}
