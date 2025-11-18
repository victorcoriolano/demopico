import 'package:demopico/features/mapa/domain/entities/pico_favorito.dart';

class PicoFavoritoModel  {
  final String id;
  final String idPico;
  final String idUsuario;

  PicoFavoritoModel({
    required this.idPico,
    required this.idUsuario,
    required this.id,
  });

  Map<String, dynamic> toMap(){
    return {
      'idPico': idPico,
      'idUsuario': idUsuario,
      'id': id,
    };
  }
}
