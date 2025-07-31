
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
  double initialNota = 0;
  int numeroAvaliacoes = 0;

  Pico(
    {
      double? nota,
      int? numeroDeAvaliacoes,
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
  }): initialNota = nota ?? 0,
    numeroAvaliacoes = numeroDeAvaliacoes ?? 0;

  (double, int) updateNota(double newNota){
    
    if (numeroAvaliacoes == 0) {
      // Primeira avaliação
      initialNota = newNota;
      numeroAvaliacoes ++;
      return (initialNota, numeroAvaliacoes);
    } else {
      // Atualiza média com base nas avaliações existentes
      initialNota = ((initialNota * numeroAvaliacoes) + newNota) /
          (numeroAvaliacoes + 1);
      numeroAvaliacoes ++;
      return (initialNota, numeroAvaliacoes);
    }
  }
}

