import 'package:demopico/features/mapa/domain/entities/pico_favorito.dart';

class PicoFavoritoModel extends PicoFavorito {
  final String id;

  PicoFavoritoModel({
    required super.idPico,
    required super.idUsuario,
    required this.id,
  });
}

class FavoriteInfoSpotModel  extends FavoriteInfoSpot {
  FavoriteInfoSpotModel(
      {required super.urlImgs,
      required super.nomePico,
      required super.userCriator,
      required super.lat,
      required super.lng});

  factory FavoriteInfoSpotModel.fromJson(Map<String, dynamic> data) {
    return FavoriteInfoSpotModel(
      urlImgs: data['imgUrl'],
      nomePico: data['picoNome'], 
      userCriator: data['userCriator'],
      lat: data['latitude'],
      lng: data['longitude'],
    );
  }
  

}