import 'package:google_maps_flutter/google_maps_flutter.dart';

class Pico {
  final String urlIdPico;
  final String picoName;
  final String? description;
  final LatLng position;
  final String userCreator;// id do usuário que for criar 
  final List<String> fotoPico;
  final List<String> utilidades;// utilidades do tipo água, banheiro etc
  final Map<String, int> atributos;
  final List<String> obstaculos;

  Pico( 
    {required this.description, 
    required this.atributos,
    required this.fotoPico,
    required this.obstaculos,
    required this.utilidades,
    required this.userCreator,
    required this.position, 
    required this.urlIdPico, 
    required this.picoName,}
  );
}