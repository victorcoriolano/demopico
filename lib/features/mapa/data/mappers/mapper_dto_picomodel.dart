import 'package:demopico/features/mapa/data/dtos/firebase_dto.dart';
import 'package:demopico/features/mapa/domain/models/pico_model.dart';

class MapperDtoPicomodel {
  static PicoModel fromDto(FirebaseDTO dto) {
    return PicoModel.fromJson(dto.data, dto.id);    
  }

  static FirebaseDTO toDto(PicoModel pico) {
    return FirebaseDTO(
      id: pico.id,
      data: pico.toMap(),
    );
  }
}