
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

