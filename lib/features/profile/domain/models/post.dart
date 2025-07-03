class Post {
  String id;
  String nome;     
  String userId;
  String spotID;             
  String urlUserPhoto;
  String description;
  List<String> urlMidia;
  DateTime dateTime;
  int curtidas;

  Post({
    required this.id,
    required this.nome,
    required this.userId,
    required this.spotID,
    required this.urlUserPhoto,
    required this.description,
    required this.urlMidia,
    DateTime? dateTime,
    int? curtidas,
  })  : dateTime = dateTime ?? DateTime.now(),
        curtidas = curtidas ?? 0;

  // Métodos GET
  String getNome() {
    return nome;
  }

  String getUrlUserPhoto() {
    return urlUserPhoto;
  }

  String getUserID() {
    return nome;
  }

    String getPostID() {
    return nome;
  }

  String getDescription() {
    return description;
  }

  List<String> geturlMidia() {
    return urlMidia;
  }

  DateTime getDateTime() {
    return dateTime;
  }

  // Métodos SET
  void setNome(String value) {
    nome = value;
  }

  void setUserId(String value) {
    userId = value;
  }

  void setSpotId(String value) {
    spotID = value;
  }

  void setUrlUserPhoto(String value) {
    urlUserPhoto = value;
  }

  void setDescription(String value) {
    description = value;
  }

  void seturlMidia(List<String> value) {
    urlMidia = value;
  }

  void setCurtidas(int value) {
    curtidas = value;
  }

  factory Post.fromJson(Map<String, dynamic> json, String id) {
    return Post(
      id: id,
      nome: json['nome'],
      spotID: json['spotID'] ?? '', 
      userId: json['userId'],
      urlUserPhoto: json['urlUserPhoto'],
      description: json['description'],
      urlMidia: List<String>.from(json['urlMidia']),
      dateTime: DateTime.parse(json['dateTime']),
      curtidas: json['curtidas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'userId': userId,
      'spotId': spotID,
      'urlUserPhoto': urlUserPhoto,
      'description': description,
      'urlMidia': urlMidia,
      'dateTime': dateTime.toIso8601String(),
      'curtidas': curtidas,
    };
  }

  
}
