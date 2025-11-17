import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/mapa/data/data_sources/interfaces/i_favorite_spot_remote_datasource.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/core/common/mappers/firebase_errors_mapper.dart';
import 'package:demopico/core/common/mappers/mapper_pico_favorito_firebase.dart';

class FirebaseFavoriteSpotRemoteDataSource
    implements IFavoriteSpotRemoteDataSource<FirebaseDTO> {
  static FirebaseFavoriteSpotRemoteDataSource? _favoriteSpotService;
  static FirebaseFavoriteSpotRemoteDataSource get getInstance {
    _favoriteSpotService ??= FirebaseFavoriteSpotRemoteDataSource(
        firebaseFirestore: FirebaseFirestore.instance);
    _favoriteSpotService!.firebaseFirestore.settings = const Settings(
      persistenceEnabled: true,
    );
    return _favoriteSpotService!;
  }

  FirebaseFavoriteSpotRemoteDataSource({required this.firebaseFirestore});

  final FirebaseFirestore firebaseFirestore;

  @override
  Future<FirebaseDTO> saveSpot(FirebaseDTO picoFav) async {
    try {
      final data =
          MapperFavoriteSpotFirebase.toFirebase(picoFav);

      final snapshot =
          await firebaseFirestore.collection("picosFavoritados").add(data);
      await firebaseFirestore
          .collection("spots")
          .doc(picoFav.data["idPico"])
          .update({
        "favoritedBy": FieldValue.arrayUnion([picoFav.data["idUser"]])
      });

      final docPicoFav = await snapshot.get();
      return FirebaseDTO.fromDocumentSnapshot(docPicoFav)
        ..resolveReference("idPico");
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    } on Exception catch (e, stackTrace) {
      throw UnknownFailure(originalException: e, stackTrace: stackTrace);
    } catch (e, st) {
      throw UnknownError(message: "Erro desconhecido: $e", stackTrace: st);
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
        return FirebaseDTO.fromDocumentSnapshot(doc)
          ..resolveReference("idPico");
      }).toList();
    } on FirebaseException catch (e, st) {
      throw FirebaseErrorsMapper.map(e, st);
    }
  }

  @override
  Future<void> removeFavorito(FirebaseDTO picoFav) async {
    try {
     final campo = await firebaseFirestore
          .collection("picosFavoritados")
          .where("idUser", isEqualTo: picoFav.data["idUser"])
          .where("idPico", isEqualTo: picoFav.data["idPico"])
          .get();
       for (var doc in campo.docs) {
    await doc.reference.delete();
  }   
      await firebaseFirestore
          .collection("spots")
          .doc(picoFav.data["idPico"])
          .update({
        "favoritedBy": FieldValue.arrayRemove([picoFav.data["idUser"]])
      });
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    } catch (e, st) {
      throw UnknownFailure(originalException: e as Exception, stackTrace: st);
    }
  }
}
