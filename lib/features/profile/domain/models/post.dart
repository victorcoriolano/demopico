class Post {
  String id;
  String nome;     
  String userId;
  String postId;             
  String urlUserPhoto;
  String description;
  List<String> urlPhotos;
  DateTime dateTime;
  int curtidas;

  Post({
    required this.id,
    required this.nome,
    required this.userId,
    required this.postId,
    required this.urlUserPhoto,
    required this.description,
    required this.urlPhotos,
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

  List<String> getUrlPhotos() {
    return urlPhotos;
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

    void setPostId(String value) {
    postId = value;
  }

  void setUrlUserPhoto(String value) {
    urlUserPhoto = value;
  }

  void setDescription(String value) {
    description = value;
  }

  void setUrlPhotos(List<String> value) {
    urlPhotos = value;
  }

  void setCurtidas(int value) {
    curtidas = value;
  }

  factory Post.fromJson(Map<String, dynamic> json, String id) {
    return Post(
      id: id,
      nome: json['nome'],
      userId: json['userId'],
      postId: json['postId'],
      urlUserPhoto: json['urlUserPhoto'],
      description: json['description'],
      urlPhotos: List<String>.from(json['urlPhotos']),
      dateTime: DateTime.parse(json['dateTime']),
      curtidas: json['curtidas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'userId': userId,
      'postId': postId,
      'urlUserPhoto': urlUserPhoto,
      'description': description,
      'urlPhotos': urlPhotos,
      'dateTime': dateTime.toIso8601String(),
      'curtidas': curtidas,
    };
  }
}
