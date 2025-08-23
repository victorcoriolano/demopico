
import 'package:demopico/features/user/domain/models/user.dart';

class Pico {
  final UserM? user;
  final String id;
  final String modalidade;
  final String tipoPico;
  final String picoName;
  final List<String> imgUrls;
  final String description;
  final double long;
  final double lat;
  final List<String> utilidades; 
  final Map<String, int> atributos;
  final List<String> obstaculos;
  final String? userName;
  final String? userID;
  double rating;
  int numberOfReviews;

  Pico(
    {
      double? newRating,
      int? countReviews,
      this.userName,
      this.userID,
      this.user,
      required this.imgUrls,
      required this.modalidade,
      required this.tipoPico,
      required this.long, required this.lat, 
      required this.description,
      required this.atributos,
      required this.obstaculos,
      required this.utilidades,
      required this.id,
      required this.picoName,
  }): rating = newRating ?? 0,
    numberOfReviews = countReviews ?? 0;

  (double, int) updateNota(double newNota){
    
    if (numberOfReviews == 0) {
      // Primeira avaliação
      rating = newNota;
      numberOfReviews ++;
      return (rating, numberOfReviews);
    } else {
      // Atualiza média com base nas avaliações existentes
      rating = double.parse((((rating * numberOfReviews) + newNota) /
          (numberOfReviews + 1)).toStringAsFixed(2));
      numberOfReviews ++;
      return (rating, numberOfReviews);
    }
  }
  
  set newRating(double rating){
    this.rating = rating;
  }
}



enum TypeSpot {
  rua,
  half,
  bowl,
  street,
  skatePark;

  String get name {
    switch(this){
      case TypeSpot.rua: return "Pico de rua";
      case TypeSpot.half: return 'Half';
      case TypeSpot.bowl: return 'Bowl';
      case TypeSpot.street: return 'Street';
      case TypeSpot.skatePark: return 'SkatePark';
    }
  }  

  factory TypeSpot.fromString(String value){
    switch (value){
      case ("Pico de rua"): return TypeSpot.rua;
      case ('Half'): return TypeSpot.half;
      case ('Bowl'): return TypeSpot.bowl;
      case ('Street'): return TypeSpot.street;
      case ('SkatePark'): return TypeSpot.skatePark;
      default: return TypeSpot.rua;
    }
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
      default: return  ModalitySpot.skate;
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

class Modality {
  final ModalitySpot modalidade;

  Modality({required this.modalidade});

  
}


