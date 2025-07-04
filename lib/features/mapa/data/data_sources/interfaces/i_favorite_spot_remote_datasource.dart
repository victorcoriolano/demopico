import 'package:demopico/core/common/files/dtos/firebase_dto.dart';


abstract class IFavoriteSpotRemoteDataSource {
  Future<FirebaseDTO> saveSpot(FirebaseDTO pico);
  Future<List<FirebaseDTO>> listFavoriteSpot(String idUser);
  Future<void> removeFavorito(String id);

}

