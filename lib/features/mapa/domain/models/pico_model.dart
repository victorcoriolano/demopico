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
      'imageUrls': super.imgUrls,
      'tipo': super.tipoPico,
      'modalidade': super.modalidade,
      'nota': super.nota,
      'avaliacoes': super.numeroAvaliacoes,
      'longitude': super.long,
      'latitude': super.lat,
      'description': super.description,
      'atributos': super.atributos,
      'obstaculos': super.obstaculos,
      'utilidades': super.utilidades,
      'userCreator': super.userCreator,
      'picoName': super.picoName,
    };
  }


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return false;
  }

  PicoModel copyWith({
    List<String>? imgUrls,
    String? tipoPico,
    String? modalidade,
    double? nota,
    int? numeroAvaliacoes,
    double? long,
    double? lat,
    String? description,
    Map<String, int>? atributos,
    List<String>? obstaculos,
    List<String>? utilidades,
    String? userCreator,
    String? picoName,
  }){
    return PicoModel(
      imgUrls: imgUrls ?? this.imgUrls,
      tipoPico: tipoPico ?? this.tipoPico,
      modalidade: modalidade ?? this.modalidade,
      nota: nota ?? this.nota,
      numeroAvaliacoes: numeroAvaliacoes ?? this.numeroAvaliacoes,
      long: long ?? this.long,
      lat: lat ?? this.lat,
      description: description ?? this.description,
      atributos: atributos ?? this.atributos,
      obstaculos: obstaculos ?? this.obstaculos,
      utilidades: utilidades ?? this.utilidades,
      userCreator: userCreator ?? this.userCreator,
      picoName: picoName ?? this.picoName,
      id: id,
    );
  }
}
