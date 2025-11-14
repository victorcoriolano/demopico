import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/mapa/domain/entities/pico_favorito.dart';
import 'package:demopico/features/mapa/domain/models/pico_favorito_model.dart';

class MapperFavoriteSpotFirebase {
  static FirebaseDTO toDto(PicoFavorito picoFavorito) {
    return FirebaseDTO(
      id: "",
      data: {
        'idUser': picoFavorito.idUsuario,
        'idPico': picoFavorito.idPico,
      }
    );
  }
  static PicoFavoritoModel fromDto(FirebaseDTO dto) {
    dto = dto.resolveReference("idPico");
    return PicoFavoritoModel(
      idPico: dto.data['idPico'],
      idUsuario: dto.data['idUser'],
      id: dto.id,
    );
  }

  static Map<String, dynamic> toFirebase(FirebaseDTO picoFavorito) {
    return {
      'idUser': picoFavorito.data['idUser'] as String,
      'idPico': picoFavorito.data['idPico'] as String,
    };
  }
}