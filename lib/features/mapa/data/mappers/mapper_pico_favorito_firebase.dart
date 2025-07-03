import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/files/dtos/firebase_dto.dart';
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
    return PicoFavoritoModel(
      idPico: dto.data['idPico'],
      idUsuario: dto.data['idUser'],
      id: dto.id,
    );
  }
  static FirebaseDTO fromFirebase(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>;

    return FirebaseDTO(
      id: doc.id,
      data: {
        'idUser': data['idUser'] as String,
        'idPico': (data['spotRef'] as DocumentReference).id,
      }
    );
  }

  static Map<String, dynamic> toFirebase(FirebaseDTO picoFavorito, FirebaseFirestore firebaseInstance) {
    return {
      'idUser': picoFavorito.data['idUser'] as String,
      'spotRef': firebaseInstance
        .collection('spots')  
        .doc(picoFavorito.data["idPico"]),
    };
  }
}