import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';

class PicoModel extends Pico {
  String idPico;
  PicoModel(
      {required this.idPico,
        required super.imgUrl,
      required super.modalidade,
      required super.tipoPico,
      required super.nota,
      required super.numeroAvaliacoes,
      required super.long,
      required super.lat,
      required super.description,
      required super.atributos,
      required super.fotoPico,
      required super.obstaculos,
      required super.utilidades,
      required super.userCreator,
      required super.picoName});

  factory PicoModel.fromJson(Map<String, dynamic> json) {
    return PicoModel(
      idPico: json['id'] as String,
      imgUrl: json['imageUrl'] as List<dynamic>,
      tipoPico: json['tipo'] as String,
      modalidade: json['modalidade'] as String,
      nota: (json['nota'] as num).toDouble(),
      numeroAvaliacoes: json['avaliacoes'] as int,
      long: (json['longitude'] as num).toDouble(),
      lat: (json['latitude'] as num).toDouble(),
      description: json['description'] as String,
      atributos: json['atributos'] as Map<String, dynamic>,
      fotoPico: null,
      obstaculos: json['obstaculos'] as List<dynamic>,
      utilidades: json['utilidades'] as List<dynamic>,
      userCreator: json['userCreator'] as String,
      picoName: json['picoName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imgUrl,
      'tipo': tipoPico,
      'modalidade': modalidade,
      'nota': nota,
      'avaliacoes': numeroAvaliacoes,
      'longitude': long,
      'latitude': lat,
      'description': description,
      'atributos': atributos,
      'fotoPico': fotoPico,
      'obstaculos': obstaculos,
      'utilidades': utilidades,
      'userCreator': userCreator,
      'picoName': picoName,
    };
  }

}