import 'package:demopico/features/mapa/domain/models/pico_favorito_model.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';

class SpotCardUIDto {
  PicoModel picoModel;
  PicoFavoritoModel picoFavoritoModel;

  SpotCardUIDto({
    required this.picoModel,
    required this.picoFavoritoModel,
  });
}
