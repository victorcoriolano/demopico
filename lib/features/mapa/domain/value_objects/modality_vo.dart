
import 'package:demopico/core/common/errors/domain_failures.dart';

class ModalityVo {
  final List<String> utilities;
  final ModalitySpot value;

  ModalityVo._({required this.utilities, required this.value});

  factory ModalityVo(List<String> utilities, ModalitySpot value){
    if (!value.validUtilities(utilities)){
      throw InvalidAttributeError(message: "Utilidades não estão mapeadas na aplicação: $utilities");
    }
    return ModalityVo._(utilities: utilities, value: value);
  }

}

enum ModalitySpot{
  skate,
  parkour,
  bmx;

  factory ModalitySpot.fromString(String value){
    switch (value) {
      case 'Skate': return ModalitySpot.skate;
      case 'Parkour': return ModalitySpot.parkour;
      case 'BMX': return ModalitySpot.bmx;
      default: throw ArgumentError('Invalid modality spot - $value');
    }
  }

  String get name{
    switch (this) {
      case ModalitySpot.skate:
        return "Skate";
      case ModalitySpot.parkour:
        return "Parkour";
      case ModalitySpot.bmx:
        return "BMX";
    }
  }

  List get utilitiesByModality{
        return [
          'Água',
          'Teto',
          'Banheiro',
          'Suave Arcadiar',
          'Público / Gratuito',
          'Mecânicas Próximas',
          'Ar Livre',
        ];
  }

  bool validUtilities(List<String> utilities){
    return utilitiesByModality.toSet().containsAll(utilities);
  }
}








