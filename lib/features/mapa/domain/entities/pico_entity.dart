
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/core/common/auth/domain/value_objects/location_vo.dart';
import 'package:demopico/features/mapa/domain/factories/spot_factory.dart';
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
  final ModalityVo modalidade;
  final TypeSpotVo tipoPico;
  final LocationVo location;
  final AttributesVO atributosVO;
  final ObstacleVo obstaculos;
  final RatingVo rating;    
  final List<String>? reviewersUsers;
  final List<String>? idPostOnThis;

  Pico._(
    {
      this.user,
      required this.reviewersUsers,
      required this.idPostOnThis,
      required this.rating,
      required this.imgUrls,
      required this.modalidade,
      required this.tipoPico,
      required this.location,
      required this.description,
      required this.atributosVO,
      required this.obstaculos,
      required this.id,
      required this.picoName,
  });

  static PicoBuilder build() => PicoBuilder();

}

class PicoBuilder {
  String? id;
  String? picoName;
  String? description;
  List<String> imgUrls = [];
  UserIdentification? user;
  ModalityVo? modalidade;
  LocationVo? location;
  RatingVo? rating;
  List<String>? reviewersUsers;
  List<String>? idPostOnThis;

  // dados opcionais para factory
  Map<String, dynamic>? attributesData;
  String? typeValue;
  List<String>? obstaclesValue;

  // Setters encadeados
  PicoBuilder withId(String v) { id = v; return this; }
  PicoBuilder withPicoName(String v) { picoName = v; return this; }
  PicoBuilder withDescription(String v) { description = v; return this; }
  PicoBuilder withImgUrls(List<String> v) { imgUrls = v; return this; }
  PicoBuilder withUser(UserIdentification? u) { user = u; return this; }
  PicoBuilder withLocation(LocationVo l) { location = l; return this; }
  PicoBuilder withModalidade(ModalityVo m) { modalidade = m; return this; }
  PicoBuilder withReviewers(List<String> r) { reviewersUsers = r; return this; }
  PicoBuilder withPosts(List<String> p) { idPostOnThis = p; return this; }
  PicoBuilder withRating(RatingVo v) { rating = v; return this; }

  // dados auxiliares para factories
  PicoBuilder withAttributesData(Map<String, dynamic> data) { attributesData = data; return this; }
  PicoBuilder withTypeValue(String v) { typeValue = v; return this; }
  PicoBuilder withObstacles(List<String> v) { obstaclesValue = v; return this; }
  

  Pico build() {
    // TODO CORRIGIR AS VALIDAÇÕES 
    if (id == null || picoName == null || description == null || modalidade == null || location == null || rating == null) {
      throw StateError("Campos obrigatórios: id, picoName, description, modalidade, location");
    }

    // 🔑 usa a SpotFactory conforme a modalidade
    final attributes = SpotFactory.createAttributes(modalidade!.value, attributesData);
    final type = SpotFactory.createType(modalidade!.value, typeValue);
    final obstacles = SpotFactory.createObstacles(modalidade!.value, obstaclesValue);

    return Pico._(
      id: id!,
      picoName: picoName!,
      description: description!,
      imgUrls: imgUrls,
      user: user,
      modalidade: modalidade!,
      tipoPico: type,
      location: location!,
      atributosVO: attributes,
      obstaculos: obstacles,
      rating: rating!,
      reviewersUsers: reviewersUsers,
      idPostOnThis: idPostOnThis,
    );
  }
}



