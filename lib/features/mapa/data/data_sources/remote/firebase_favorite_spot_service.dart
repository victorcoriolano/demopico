import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/mapa/data/data_sources/interfaces/i_favorite_spot_remote_datasource.dart';
import 'package:demopico/features/mapa/data/dtos/firebase_dto.dart';
import 'package:demopico/features/mapa/data/mappers/firebase_errors_mapper.dart';
import 'package:demopico/features/mapa/data/mappers/mapper_pico_favorito_firebase.dart';

class FirebaseFavoriteSpotRemoteDataSource implements IFavoriteSpotRemoteDataSource {

  static FirebaseFavoriteSpotRemoteDataSource? _favoriteSpotService;
  static FirebaseFavoriteSpotRemoteDataSource get getInstance {
    _favoriteSpotService ??= FirebaseFavoriteSpotRemoteDataSource(firebaseFirestore: FirebaseFirestore.instance);
    return _favoriteSpotService!;
  }
    
  FirebaseFavoriteSpotRemoteDataSource({required this.firebaseFirestore});

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
      throw FirebaseErrorsMapper.map(e);
    } on Exception catch (e, stackTrace) {
      throw UnknownFailure(originalException: e ,stackTrace: stackTrace);
    }catch (e, st) {
      throw UnknownError("Erro desconhecido: $e", stackTrace: st);
    }
  }

  @override
  Future<List<FirebaseDTO>> listFavoriteSpot(String idUser) async {
    try {
      final snapshot = await firebaseFirestore
          .collection("picosFavoritados")
          .where("idUser", isEqualTo: idUser)
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
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    }catch (e, st) {
      throw UnknownFailure(originalException: e as Exception, stackTrace: st);
    }
  }
}
