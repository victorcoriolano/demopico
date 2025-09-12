
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/core/common/auth/domain/value_objects/location_vo.dart';
import 'package:demopico/features/mapa/domain/value_objects/attributes_vo.dart';
import 'package:demopico/features/mapa/domain/value_objects/modality_vo.dart';
import 'package:demopico/features/mapa/domain/value_objects/obstacle_vo.dart';
import 'package:demopico/features/mapa/domain/value_objects/rating_vo.dart';
import 'package:demopico/features/mapa/domain/value_objects/type_spot_vo.dart';

class Pico {
  final String id;
  final String picoName;
  final String description;
  final List<String> imgUrls;
  final UserIdentification? user;
  final ModalitySpot modalidade;
  final TypeSpotVo tipoPico;
  final LocationVo location;
  final AttributesVO atributos;
  final ObstacleVo obstaculos;
  final RatingVo rating;    
  final List<String> reviewersUsers;
  final List<String> idPostOnThis;

  Pico(
    {
      this.user,
      this.reviewersUsers = const [],
      this.idPostOnThis = const [],
      required this.rating,
      required this.imgUrls,
      required this.modalidade,
      required this.tipoPico,
      required this.location,
      required this.description,
      required this.atributos,
      required this.obstaculos,
      required this.id,
      required this.picoName,
  });
}




