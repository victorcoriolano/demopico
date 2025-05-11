import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/mapa/data/adapters/pico_favorito_adapter.dart';
import 'package:demopico/features/mapa/domain/entities/pico_favorito.dart';
import 'package:demopico/features/mapa/domain/models/pico_favorito_model.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_favorite_spot_repository.dart';

class FirebaseFavoriteSpotService implements IFavoriteSpotRepository {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseFavoriteSpotService(this._firebaseFirestore);

  @override
  Future<void> deleteSave(String idPicoFavorito) async {
    try {
      await _firebaseFirestore
          .collection("picosFavoritados")
          .doc(idPicoFavorito)
          .delete();
    } catch (e) {
      throw Exception("Erro ao deletar o pico favoritado: $e");
    }
  }

  @override
  Future<PicoFavoritoModel> saveSpot(PicoFavorito picoFav) async {
    try {
      final data = PicoFavoritoAdapter.toFirebase(picoFav, _firebaseFirestore);

      final snapshot =
          await _firebaseFirestore.collection("picosFavoritados").add(data);
      final docPicoFav = await snapshot.get();
      return PicoFavoritoAdapter.fromFirebase(docPicoFav);
    } on FirebaseException catch (e) {
      throw Exception("Erro no firevase ao salvar pico: $e");
    } catch (e) {
      throw Exception("Erro desconhecido ao salvar pico: $e");
    }
  }

  @override
  Future<List<PicoFavoritoModel>> listFavoriteSpot(String idUser) async {
    try {
      final snapshot = await _firebaseFirestore
          .collection("picosFavoritados")
          .where("idUsuario", isEqualTo: idUser)
          .get();
      return snapshot.docs.map((doc) {
        return PicoFavoritoAdapter.fromFirebase(doc);
      }).toList();
    } catch (e) {
      throw Exception("Erro ao listar os picos favoritos: $e");
    }
  }
}
