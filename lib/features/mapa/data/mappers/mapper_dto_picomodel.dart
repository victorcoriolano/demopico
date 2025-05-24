import 'package:demopico/features/mapa/data/dtos/spot_firebase_dto.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';

class MapperDtoPicomodel {
  static PicoModel fromDto(SpotFirebaseDTO dto) {
    return PicoModel.fromJson(dto.data, dto.id);    
  }

  static SpotFirebaseDTO toDto(PicoModel pico) {
    return SpotFirebaseDTO(
      id: pico.id,
      data: pico.toJson(),
    );
  }
}