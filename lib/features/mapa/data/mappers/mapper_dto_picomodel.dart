import 'package:demopico/features/mapa/data/dtos/pico_model_firebase_dto.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';

class MapperDtoPicomodel {
  static PicoModel fromDto(PicoFirebaseDTO dto) {
    return PicoModel.fromJson(dto.data, dto.id);    
  }

  static PicoFirebaseDTO toDto(PicoModel pico) {
    return PicoFirebaseDTO(
      id: pico.id,
      data: pico.toJson(),
    );
  }
}