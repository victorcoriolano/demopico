import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/core/common/auth/domain/value_objects/location_vo.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/value_objects/modality_vo.dart';
import 'package:demopico/features/mapa/domain/value_objects/rating_vo.dart';


const _padrao = "Não informado";

class PicoModel {
  final String id;
  final String picoName;
  final String description;
  final List<String> imgUrls;
  final UserIdentification? userIdentification;

  // primitivos que serão convertidos
  final String modalidade;  
  final String tipoPico;
  final double longitude;
  final double latitude;
  final Map<String, dynamic> atributos;
  final List<String> obstaculos;
  final List<String> utilities;
  final List<String>? reviewersUsers;
  final List<String>? idPostOnThis;
  final double nota;
  final int avaliacoes;

  PicoModel({
    required this.idPostOnThis,
    required this.reviewersUsers,
    required this.id,
    required this.picoName,
    required this.description,
    required this.imgUrls,
    required this.modalidade,
    required this.utilities,
    required this.tipoPico,
    required this.longitude,
    required this.latitude,
    required this.atributos,
    required this.obstaculos,
    required this.nota,
    required this.avaliacoes,
    required this.userIdentification,
  });

  /// 🔹 Converte JSON vindo do Firestore em Model
  factory PicoModel.fromJson(Map<String, dynamic> json, String id) {
    return PicoModel(
      id: id,
      utilities: json['utilidades'] ?? [],
      picoName: json['name'] ?? _padrao,
      description: json['description'] ?? _padrao,
      imgUrls: List<String>.from(json['imageUrl'] ?? []),
      modalidade: json['modalidade'] ?? _padrao,
      tipoPico: json['tipo'] ?? _padrao,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      atributos: Map<String, dynamic>.from(json['atributos'] ?? {}),
      obstaculos: List<String>.from(json['obstaculos'] ?? []),
      nota: (json['nota'] as num?)?.toDouble() ?? 0.0,
      avaliacoes: json['avaliacoes'] ?? 0,
      userIdentification: json["creatorUser"] != null ? UserIdentification.fromJson(json["creatorUser"]) : null,
      reviewersUsers: List.from(json["userReviewers"] ?? []),
      idPostOnThis: List.from(json["idPostOnThis"] ?? [])
    );
  }

  /// 🔹 Converte Model → Entidade rica (com VO)
Pico toEntity() {
  final modalityEnum = ModalitySpot.fromString(modalidade);

  return PicoBuilder()
    .withId(id)
    .withPicoName(picoName)
    .withDescription(description)
    .withImgUrls(imgUrls)
    .withUser(userIdentification)
    .withModalidade(ModalityVo(utilities, modalityEnum))
    .withLocation(LocationVo(latitude: latitude, longitude: longitude))
    .withReviewers(reviewersUsers ?? [])
    .withPosts(idPostOnThis ?? [])
    .withAttributesData(atributos) // passa o map que SpotFactory vai resolver
    .withTypeValue(tipoPico)      // passa a string que SpotFactory vai resolver
    .withObstacles(obstaculos)    // passa a lista que SpotFactory vai resolver
    .withRating(RatingVo(nota, avaliacoes))
    .build();
}


  /// 🔹 Converte Entidade → Model (para salvar no banco)
  factory PicoModel.fromEntity(Pico pico) {
    return PicoModel(
      id: pico.id,
      picoName: pico.picoName,
      description: pico.description,
      imgUrls: pico.imgUrls,
      modalidade: pico.modalidade.value.name,
      utilities: pico.modalidade.utilities,
      tipoPico: pico.tipoPico.selectedValue,
      longitude: pico.location.longitude,
      latitude: pico.location.latitude,
      atributos: pico.atributosVO.attributes,
      obstaculos: pico.obstaculos.obstacles,
      nota: pico.rating.average,
      avaliacoes: pico.rating.numberOfReviews,
      userIdentification: pico.user,
      idPostOnThis: pico.idPostOnThis,
      reviewersUsers: pico.reviewersUsers,
    );
  }

  /// 🔹 Converte Model → Map (para Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': picoName,
      'description': description,
      'imageUrl': imgUrls,
      'modalidade': modalidade,
      'tipo': tipoPico,
      'longitude': longitude,
      'latitude': latitude,
      'atributos': atributos,
      'obstaculos': obstaculos,
      'nota': nota,
      'avaliacoes': avaliacoes,
      'creatorUser': userIdentification?.toJson(),
    };
  }
}

extension PicoModelCopyWith on PicoModel {
  PicoModel copyWith({
    String? id,
    String? picoName,
    String? description,
    List<String>? imgUrls,
    UserIdentification? userIdentification,
    String? modalidade,
    String? tipoPico,
    double? longitude,
    double? latitude,
    Map<String, dynamic>? atributos,
    List<String>? obstaculos,
    List<String>? utilities,
    List<String>? reviewersUsers,
    List<String>? idPostOnThis,
    double? nota,
    int? avaliacoes,
  }) {
    return PicoModel(
      id: id ?? this.id,
      picoName: picoName ?? this.picoName,
      description: description ?? this.description,
      imgUrls: imgUrls ?? this.imgUrls,
      userIdentification: userIdentification ?? this.userIdentification,
      modalidade: modalidade ?? this.modalidade,
      tipoPico: tipoPico ?? this.tipoPico,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      atributos: atributos ?? this.atributos,
      obstaculos: obstaculos ?? this.obstaculos,
      utilities: utilities ?? this.utilities,
      reviewersUsers: reviewersUsers ?? this.reviewersUsers,
      idPostOnThis: idPostOnThis ?? this.idPostOnThis,
      nota: nota ?? this.nota,
      avaliacoes: avaliacoes ?? this.avaliacoes,
    );
  }
}
