class PicoFavorito {
  String idPico;
  String idUsuario;


  PicoFavorito({
    required this.idPico,
    required this.idUsuario,
  });
}

class FavoriteInfoSpot {
  List<String> urlImgs;
  String nomePico;
  String userCriator;
  double lat;
  double lng;

 FavoriteInfoSpot({
    required this.urlImgs,
    required this.nomePico,
    required this.userCriator,
    required this.lat,
    required this.lng,
  });
}