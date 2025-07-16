import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';


abstract class IFavoriteSpotRemoteDataSource {
  Future<FirebaseDTO> saveSpot(FirebaseDTO pico);
  Future<List<FirebaseDTO>> listFavoriteSpot(String idUser);
  Future<void> removeFavorito(String id);

}

