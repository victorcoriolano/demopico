import 'dart:io';

class Pico {
  final String urlIdPico;
  final String modalidade;
  final String tipoPico;
  final String picoName;
  final List<dynamic> imgUrl;// link mostrar imagem 
  final String? description;
  final double long;
  final double lat;
  final String? userCreator; // id do usuário que for criar
  final File? fotoPico;
  final List<dynamic>? utilidades; // utilidades do tipo água, banheiro etc
  final Map<String, dynamic>? atributos;
  final List<dynamic>? obstaculos;
  double? nota;
  int? numeroAvaliacoes;
  // final Map<Comentarios>

  Pico(
    {
      required this.imgUrl,
      required this.modalidade,
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

    factory Pico.fromJson(Map<String, dynamic> json) {
    return Pico(
      urlIdPico: json['urlIdPico'] as String,
      modalidade: json['modalidade'] as String,
      tipoPico: json['tipoPico'] as String,
      picoName: json['picoName'] as String,
      imgUrl: List<dynamic>.from(json['imgUrl'] ?? []),
      description: json['description'] as String?,
      long: (json['long'] as num).toDouble(),
      lat: (json['lat'] as num).toDouble(),
      userCreator: json['userCreator'] as String?,
      fotoPico: null, 
      utilidades: json['utilidades'] != null ? List<dynamic>.from(json['utilidades']) : [],
      atributos: json['atributos'] as Map<String, dynamic>?,
      obstaculos: json['obstaculos'] != null ? List<dynamic>.from(json['obstaculos']) : [],
      nota: json['nota'] != null ? (json['nota'] as num).toDouble() : null,
      numeroAvaliacoes: json['numeroAvaliacoes'] as int?,
    );
  }

  /// Converte um objeto Pico em um Map (Firestore ou JSON)
  Map<String, dynamic> toMap() {
    return {
      'urlIdPico': urlIdPico,
      'modalidade': modalidade,
      'tipoPico': tipoPico,
      'picoName': picoName,
      'imgUrl': imgUrl,
      'description': description,
      'long': long,
      'lat': lat,
      'userCreator': userCreator,
      'utilidades': utilidades,
      'atributos': atributos,
      'obstaculos': obstaculos,
      'nota': nota,
      'numeroAvaliacoes': numeroAvaliacoes,
    };
  }
}

