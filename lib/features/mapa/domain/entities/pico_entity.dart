
class Pico {
  final String id;
  final String modalidade;
  final String tipoPico;
  final String picoName;
  final List<String> imgUrls;// link mostrar imagem 
  final String? description;
  final double long;
  final double lat;
  final String? userCreator; // id do usuário que for criar
  final List<String> utilidades; // utilidades do tipo água, banheiro etc
  final Map<String, int> atributos;
  final List<String> obstaculos;
  double? nota;
  int? numeroAvaliacoes;

  Pico(
    {
      required this.imgUrls,
      required this.modalidade,
    required this.tipoPico,
    required this.nota,
    required this.numeroAvaliacoes,
    required this.long, required this.lat, 
    required this.description,
    required this.atributos,
    required this.obstaculos,
    required this.utilidades,
    required this.userCreator,
    required this.id,
    required this.picoName,
  });
}

