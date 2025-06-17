enum TypePublication {
  pico,
  anuncio,
  perfil,
  comentario,
}

class DenunciaModel {
  final List<String> type;
  final TypePublication typePublication;
  final String content;
  final String idUser;
  final String idPub;

  DenunciaModel({
    required this.type,
    required this.content,
    required this.idUser,
    required this.idPub,
    this.typePublication = TypePublication.pico,
  });

  /// Converte um JSON em uma instância de DenunciaModel
  factory DenunciaModel.fromJson(Map<String, dynamic> json) {
    return DenunciaModel(
      type: List<String>.from(json['type'] ?? []), // Converte lista do JSON
      typePublication: TypePublication.values.firstWhere(
        (e) => e.toString().split('.').last == json['typePublication'],
        orElse: () => TypePublication.pico,
      ), // Mapeia string para enum
      content: json['content'] ?? '',
      idUser: json['idUser'] ?? '',
      idPub: json['idPub'] ?? '',
    );
  }

  /// Converte uma instância de DenunciaModel em um Map 
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'typePublication': typePublication.toString().split('.').last,
      'content': content,
      'idUser': idUser,
      'idPub': idPub,
    };
  }
}
