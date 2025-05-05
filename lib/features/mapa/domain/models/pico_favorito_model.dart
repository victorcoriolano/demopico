import 'package:demopico/features/mapa/domain/entities/pico_favorito.dart';

class PicoFavoritoModel extends PicoFavorito {
  final String id;
  
  PicoFavoritoModel({
    required super.idPico,
    required super.idUsuario,
    required this.id,
  });
}