import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/mapa/data/dtos/firebase_dto.dart';
import 'package:demopico/features/mapa/domain/entities/pico_favorito.dart';
import 'package:demopico/features/mapa/domain/models/pico_favorito_model.dart';

class MapperFavoriteSpotFirebase {
  static FirebaseDTO toDto(PicoFavorito picoFavorito) {
    return FirebaseDTO(
      id: "",
      data: {
        'idUsuario': picoFavorito.idUsuario,
        'idPico': picoFavorito.idPico,
      }
    );
  }
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
      data: {
        'idUsuario': data['idUsuario'] as String,
        'idPico': data['idPico'] as DocumentReference,
      }
    );
  }

  static Map<String, dynamic> toFirebase(FirebaseDTO picoFavorito, FirebaseFirestore firebaseInstance) {
    return {
      'idUsuario': picoFavorito.data['idUsuario'] as String,
      'idPico': firebaseInstance
        .collection('spots')  
        .doc(picoFavorito.data["idPico"]),
    };
  }
}