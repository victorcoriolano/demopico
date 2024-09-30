import 'package:google_maps_flutter/google_maps_flutter.dart';

class Pico {
  final String urlIdPico;
  final String picoName;
  final String? description;
  final double long;
  final double lat;
  final String userCreator; // id do usuário que for criar
  final List<String> fotoPico;
  final List<String> utilidades; // utilidades do tipo água, banheiro etc
  final Map<String, double> atributos;
  final List<String> obstaculos;
  final double nota;
  final int numeroAvaliacoes;
  // final Map<Comentarios>

  Pico(
    this.nota,
    this.numeroAvaliacoes,{
     required this.long, required this.lat, 
    required this.description,
    required this.atributos,
    required this.fotoPico,
    required this.obstaculos,
    required this.utilidades,
    required this.userCreator,
    required this.urlIdPico,
    required this.picoName,
  });
}

