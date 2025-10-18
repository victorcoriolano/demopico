import 'package:demopico/features/mapa/data/data_sources/interfaces/i_favorite_spot_remote_datasource.dart';
import 'package:demopico/features/mapa/data/data_sources/remote/firebase_favorite_spot_service.dart';
import 'package:demopico/core/common/mappers/mapper_pico_favorito_firebase.dart';
import 'package:demopico/features/mapa/domain/entities/pico_favorito.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_favorite_spot_repository.dart';
import 'package:demopico/features/mapa/domain/models/pico_favorito_model.dart';

class FavoriteSpotRepository implements IFavoriteSpotRepository {

  static FavoriteSpotRepository? _favoriteSpotRepository;
  static FavoriteSpotRepository get getInstance {
    _favoriteSpotRepository ??= FavoriteSpotRepository(
      FirebaseFavoriteSpotRemoteDataSource.getInstance
    );
    return _favoriteSpotRepository!;
  }
  
  final IFavoriteSpotRemoteDataSource dataSource;

  FavoriteSpotRepository(this.dataSource);


  @override
  Future<void> deleteSave(String id) async{
    await dataSource.removeFavorito(id);
  }


  @override
  Future<List<PicoFavoritoModel>> listFavoriteSpot(String idUser)  async {
    final favs = await dataSource.listFavoriteSpot(idUser);
    return favs.map((fav) => MapperFavoriteSpotFirebase.fromDto(fav)).toList();
  }

  @override
  Future<PicoFavoritoModel> saveSpot(PicoFavorito pico) async {
    final dto =  MapperFavoriteSpotFirebase.toDto(pico);
    final picoFav = await dataSource.saveSpot(dto);
    return MapperFavoriteSpotFirebase.fromDto(picoFav);
  }
}
