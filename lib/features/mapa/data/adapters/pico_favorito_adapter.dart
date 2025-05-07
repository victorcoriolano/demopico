import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/mapa/domain/entities/pico_favorito.dart';
import 'package:demopico/features/mapa/domain/models/pico_favorito_model.dart';

class PicoFavoritoAdapter {
  static PicoFavoritoModel fromFirebase(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>;

    return PicoFavoritoModel(
      id: doc.id,
      idPico: (data['idPico'] as DocumentReference).id,
      idUsuario: data['idUsuario'] as String,
    );
  }

  static Map<String, dynamic> toFirebase(PicoFavorito picoFavorito, FirebaseFirestore firebaseInstance) {
    return {
      'idUsuario': picoFavorito.idUsuario,
      'idPico': firebaseInstance
        .collection('spots')  
        .doc(picoFavorito.idPico),
    };
  }
}