import 'dart:io';

class Pico {
  final String urlIdPico;
  final String modalidade;
  final String tipoPico;
  final String picoName;
  final String? description;
  final double? long;
  final double? lat;
  final String? userCreator; // id do usuário que for criar
  final File? fotoPico;
  final List<dynamic>? utilidades; // utilidades do tipo água, banheiro etc
  final Map<String, dynamic>? atributos;
  final List<dynamic>? obstaculos;
  final double? nota;
  final int? numeroAvaliacoes;
  // final Map<Comentarios>

  Pico(
    {required this.modalidade,
    required this.tipoPico,
    required this.nota,
    required this.numeroAvaliacoes,
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

