
import 'package:demopico/features/mapa/domain/value_objects/attributes_vo.dart';
import 'package:demopico/features/mapa/domain/value_objects/modality_vo.dart';
import 'package:demopico/features/mapa/domain/value_objects/obstacle_vo.dart';
import 'package:demopico/features/mapa/domain/value_objects/type_spot_vo.dart';

class SpotFactory {
  static AttributesVO createAttributes(ModalitySpot modality, [Map<String, dynamic>? data]) {
    switch(modality) {
      case ModalitySpot.skate:
        return data == null ? SkateAttributes.initial() : SkateAttributes.fromMap(data);
      case ModalitySpot.parkour:
        return data == null ? SkateAttributes.initial() : SkateAttributes.fromMap(data);
      case ModalitySpot.bmx:
        return data == null ? SkateAttributes.initial() : SkateAttributes.fromMap(data);
    }
  }

  static TypeSpotVo createType(ModalitySpot modality, [String? value]) {
    switch(modality) {
      case ModalitySpot.skate:
        return value == null ? TypeSkate.initial() : TypeSkate(value);
      case ModalitySpot.parkour:
        return TypeParkour(value ?? 'Indoor');
      case ModalitySpot.bmx:
        return TypeBMX(value ?? 'Street');
    }
  }

  static ObstacleVo createObstacles(ModalitySpot modality, [List<String>? value]) {
    switch(modality) {
      case ModalitySpot.skate:
        return ObstacleSkate.fromList(value ?? []);
      case ModalitySpot.parkour:
        return ObstacleParkour.fromList(value ?? []);
      case ModalitySpot.bmx:
        return ObstacleBMX.fromList(value ?? []);
    }
  }
}
