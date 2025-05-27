import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/mapa/data/data_sources/interfaces/i_favorite_spot_remote_datasource.dart';
import 'package:demopico/features/mapa/data/dtos/firebase_dto.dart';
import 'package:demopico/features/mapa/data/mappers/mapper_pico_favorito_firebase.dart';

class FirebaseFavoriteSpotService implements IFavoriteSpotRemoteDataSource {

  static FirebaseFavoriteSpotService? _favoriteSpotService;
  static FirebaseFavoriteSpotService get getInstance {
    _favoriteSpotService ??= FirebaseFavoriteSpotService(firebaseFirestore: FirebaseFirestore.instance);
    return _favoriteSpotService!;
  }
    
  FirebaseFavoriteSpotService({required this.firebaseFirestore});

  final FirebaseFirestore firebaseFirestore;


  @override
  Future<FirebaseDTO> saveSpot(FirebaseDTO picoFav) async {
    try {
      final data = MapperFavoriteSpotFirebase.toFirebase(picoFav, firebaseFirestore);

      final snapshot =
          await firebaseFirestore.collection("picosFavoritados").add(data);
      final docPicoFav = await snapshot.get();
      return MapperFavoriteSpotFirebase.fromFirebase(docPicoFav);
    } on FirebaseException catch (e) {
      throw Exception("Erro no firevase ao salvar pico: $e");
    } catch (e) {
      throw Exception("Erro desconhecido ao salvar pico: $e");
    }
  }

  @override
  Future<List<FirebaseDTO>> listFavoriteSpot(String idUser) async {
    try {
      final snapshot = await firebaseFirestore
          .collection("picosFavoritados")
          .where("idUsuario", isEqualTo: idUser)
          .get();
      return snapshot.docs.map((doc) {
        return MapperFavoriteSpotFirebase.fromFirebase(doc);
      }).toList();
    } catch (e) {
      throw Exception("Erro ao listar os picos favoritos: $e");
    }
  }
  
  @override
  Future<void> removeFavorito(String id) async{
    try {
      await firebaseFirestore
          .collection("picosFavoritados")
          .doc(id)
          .delete();
    } catch (e) {
      throw Exception("Erro ao deletar o pico favoritado: $e");
    }
  }
}
