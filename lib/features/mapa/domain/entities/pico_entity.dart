import 'dart:io';

class Pico {
  final String? urlIdPico;
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
    this.urlIdPico,
    required this.picoName,
  });

    factory Pico.fromJson(Map<String, dynamic> json) {
    return Pico(
        imgUrl: json['imageUrl'] as List<dynamic>,
        tipoPico: json['tipo'] as String,
        modalidade: json['modalidade'] as String,
        nota: (json['nota'] as num).toDouble(), // vai dar boum
        numeroAvaliacoes: json['avaliacoes'] as int,
        long: (json['longitude'] as num).toDouble(), // tem q dar boaum
        lat: (json['latitude'] as num).toDouble(), //  precisa dar buams
        description: json['description'] as String,
        atributos: json['atributos'] as Map<String, dynamic>,
        fotoPico: null, // vou inserir a imagem diretamente no código usando o image.network
        obstaculos: json['obstaculos'] as List<dynamic>,
        utilidades: json['utilidades'] as List<dynamic>,
        userCreator: json['criador'],
        urlIdPico: null,
        picoName: json['name'] as String,
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

