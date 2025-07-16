import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';

//mensagem de erro padrao caso o
//usuario nao tenha preenchido algum campo 
// ou o campo retornar null do bd
const _padrao = "Não informado";

class PicoModel extends Pico {

  PicoModel(
      {
        required super.userID,
        required super.userName,
        required super.imgUrls,
        required super.modalidade,
        required super.tipoPico,
        required super.nota,
        required super.numeroDeAvaliacoes,
        required super.long,
        required super.lat,
        required super.description,
        required super.atributos,
        required super.obstaculos,
        required super.utilidades,
        required super.picoName,
        required super.id}) 
      ;

      

  factory PicoModel.fromJson(Map<String, dynamic> json, String id) {
  return PicoModel(
    userID: json['idUser'],
    id: id,
    imgUrls: List<String>.from(json['imageUrl'] ?? []),
    tipoPico: json['tipo'] ?? _padrao,
    modalidade: json['modalidade'] ?? _padrao,
    nota: (json['nota'] as num?)?.toDouble() ?? 0.0,
    numeroDeAvaliacoes: json['avaliacoes'],
    long: (json['longitude'] as num?)?.toDouble() ?? 0.0,
    lat: (json['latitude'] as num?)?.toDouble() ?? 0.0,
    description: json['description'] ?? _padrao,
    atributos: Map<String, int>.from(json['atributos'] ?? {}),
    obstaculos: List<String>.from(json['obstaculos'] ?? []),
    utilidades: List<String>.from(json['utilidades'] ?? []),
    userName: json['criador'],
    picoName: json['name'] ?? _padrao,
  );
}

  factory PicoModel.fromEntity(Pico pico){
    return PicoModel(
      userID: pico.user?.id,
      id: pico.id,
      imgUrls: pico.imgUrls,
      tipoPico: pico.tipoPico,
      modalidade: pico.modalidade,
      nota: pico.initialNota,
      numeroDeAvaliacoes: pico.numeroAvaliacoes,
      long: pico.long,
      lat: pico.lat,
      description: pico.description,
      atributos: pico.atributos,
      obstaculos: pico.obstaculos,
      utilidades: pico.utilidades,
      userName: pico.user?.name,
      picoName: pico.picoName,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'idUser': userID,
      'imageUrl': super.imgUrls,
      'tipo': super.tipoPico,
      'modalidade': super.modalidade,
      'nota': super.initialNota,
      'avaliacoes': super.numeroAvaliacoes,
      'longitude': super.long,
      'latitude': super.lat,
      'description': super.description,
      'atributos': super.atributos,
      'obstaculos': super.obstaculos,
      'utilidades': super.utilidades,
      'criador': userName,
      'name': super.picoName,
    };
  }



  PicoModel copyWith({
    String? id,
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
    String? idUser,
  }){
    return PicoModel(
      userID: idUser ?? userID,
      imgUrls: imgUrls ?? this.imgUrls,
      tipoPico: tipoPico ?? this.tipoPico,
      modalidade: modalidade ?? this.modalidade,
      nota: nota ?? initialNota,
      numeroDeAvaliacoes: numeroAvaliacoes ?? this.numeroAvaliacoes,
      long: long ?? this.long,
      lat: lat ?? this.lat,
      description: description ?? this.description,
      atributos: atributos ?? this.atributos,
      obstaculos: obstaculos ?? this.obstaculos,
      utilidades: utilidades ?? this.utilidades,
      userName: userCreator ?? userName,
      picoName: picoName ?? this.picoName,
      id: id ?? this.id,
    );
  }
}
