import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/mapa/data/dtos/firebase_dto.dart';
import 'package:demopico/features/mapa/domain/models/pico_favorito_model.dart';

class MapperDtoFavoritespot {
  static PicoFavoritoModel fromDto(FirebaseDTO dto) {
    return PicoFavoritoModel(
      idPico: dto.data['idPico'],
      idUsuario: dto.data['idUsuario'],
      id: dto.id,
    );
  }


  static FirebaseDTO fromFirebase(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>;

    return FirebaseDTO(
      id: doc.id,
      data: data,
    );
  }

  static FirebaseDTO toDto(PicoFavoritoModel pico) {
    return FirebaseDTO(
      id: pico.id,
      data: pico.toJson(),
    );
  }

  
}