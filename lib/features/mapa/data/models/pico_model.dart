import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';

//mensagem de erro padrao caso o
//usuario nao tenha preenchido algum campo 
// ou o campo retornar null do bd
const _padrao = "Não informado";

class PicoModel extends Pico {
  PicoModel(
      {required super.imgUrls,
      required super.modalidade,
      required super.tipoPico,
      required super.nota,
      required super.numeroAvaliacoes,
      required super.long,
      required super.lat,
      required super.description,
      required super.atributos,
      required super.obstaculos,
      required super.utilidades,
      required super.userCreator,
      required super.picoName,
      required super.id});

      

  factory PicoModel.fromJson(Map<String, dynamic> json, String id) {
    return PicoModel(
      id: id,
      imgUrls: json['imgUrls'] ?? [],
      tipoPico: json['tipo'] ?? _padrao,
      modalidade: json['modalidade'] ?? _padrao,
      nota: (json['nota'] as num).toDouble(),
      numeroAvaliacoes: json['avaliacoes'] ?? 0,
      long: json['longitude'] ?? 0.0,
      lat: (json['latitude'] as num).toDouble(),
      description: json['description'] ?? _padrao,
      atributos: json['atributos'] ?? {},
      obstaculos: json['obstaculos'] ?? [],
      utilidades: json['utilidades'] ?? [],
      userCreator: json['userCreator'] ?? _padrao,
      picoName: json['picoName'] ?? _padrao,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrls': imgUrls,
      'tipo': tipoPico,
      'modalidade': modalidade,
      'nota': nota,
      'avaliacoes': numeroAvaliacoes,
      'longitude': long,
      'latitude': lat,
      'description': description,
      'atributos': atributos,
      'obstaculos': obstaculos,
      'utilidades': utilidades,
      'userCreator': userCreator,
      'picoName': picoName,
    };
  }


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return false;
  }
}
