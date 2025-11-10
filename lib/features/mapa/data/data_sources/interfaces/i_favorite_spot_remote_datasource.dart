abstract class IFavoriteSpotRemoteDataSource<DTO> {
  Future<DTO> saveSpot(DTO pico);
  Future<List<DTO>> listFavoriteSpot(String idUser);
  Future<void> removeFavorito(String id);
}

