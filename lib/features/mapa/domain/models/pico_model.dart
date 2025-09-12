import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/core/common/auth/domain/value_objects/location_vo.dart';
import 'package:demopico/features/mapa/domain/entities/pico_entity.dart';
import 'package:demopico/features/mapa/domain/value_objects/attributes_vo.dart';
import 'package:demopico/features/mapa/domain/value_objects/modality_vo.dart';
import 'package:demopico/features/mapa/domain/value_objects/obstacle_vo.dart';
import 'package:demopico/features/mapa/domain/value_objects/rating_vo.dart';
import 'package:demopico/features/mapa/domain/value_objects/type_spot_vo.dart';
import 'package:demopico/features/mapa/domain/factories/spot_factory.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:flutter/foundation.dart';

const _padrao = "Não informado";

class PicoModel {
  final String id;
  final String picoName;
  final String description;
  final List<String> imgUrls;
  final UserIdentification userIdentification;

  // primitivos que serão convertidos
  final String modalidade;  
  final String tipoPico;
  final double longitude;
  final double latitude;
  final Map<String, dynamic> atributos;
  final List<String> obstaculos;
  final List<String> utilities;
  final double nota;
  final int avaliacoes;

  PicoModel({
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
      utilities: json['utilidades'],
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
      userIdentification: UserIdentification.fromJson(json["creatorUser"]),
    );
  }

  /// 🔹 Converte Model → Entidade rica (com VO)
  Pico toEntity() {
    final modalityEnum = ModalitySpot.fromString(modalidade);

    return Pico(
      id: id,
      picoName: picoName,
      description: description,
      imgUrls: imgUrls,
      user: userIdentification,
      modalidade: ModalityVO(modalityEnum, utilities),
      tipoPico: SpotFactory.createType(modalityEnum, tipoPico),
      location: LocationVo(latitude: latitude, longitude: longitude),
      atributos: SpotFactory.createAttributes(modalityEnum, atributos),
      obstaculos: SpotFactory.createObstacles(modalityEnum, obstaculos),
      rating: RatingVo(nota, avaliacoes),
      reviewersUsers: [], // 🔹 precisa vir do JSON se existir
      idPostOnThis: [],   // 🔹 idem
    );
  }

  /// 🔹 Converte Entidade → Model (para salvar no banco)
  factory PicoModel.fromEntity(Pico pico) {
    return PicoModel(
      id: pico.id,
      picoName: pico.picoName,
      description: pico.description,
      imgUrls: pico.imgUrls,
      modalidade: pico.modalidade.name,
      tipoPico: pico.tipoPico.selectedValue,
      longitude: pico.location.longitude,
      latitude: pico.location.latitude,
      atributos: pico.atributos.atributos,
      obstaculos: pico.obstaculos.obstacles,
      nota: pico.rating.average,
      avaliacoes: pico.rating.numberOfReviews,
      userID: pico.user.id,
      userName: pico.user.name,
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
      'idUser': userID,
      'criador': userName,
    };
  }
}
