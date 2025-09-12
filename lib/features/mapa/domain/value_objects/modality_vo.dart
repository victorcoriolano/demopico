

enum ModalitySpot{
  skate,
  parkour,
  bmx;

  factory ModalitySpot.fromString(String value){
    switch (value) {
      case 'Skate': return ModalitySpot.skate;
      case 'Parkour': return ModalitySpot.parkour;
      case 'BMX': return ModalitySpot.bmx;
      default: throw ArgumentError('Invalid modality spot');
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
    switch (this){
      case ModalitySpot.skate:
        return [
          'Água',
          'Teto',
          'Banheiro',
          'Suave Arcadiar',
          'Público / Gratuito'
        ];
      case ModalitySpot.parkour:
        return ['Água', 'Banheiro', 'Ar Livre'];
      case ModalitySpot.bmx:
        return ['Água', 'Banheiro', 'Mecânicas Próximas', 'Ar Livre'];
    }
  }
}








