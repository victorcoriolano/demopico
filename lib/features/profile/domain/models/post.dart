class Post {
  String nome;     
  String userId;
  String postId;             
  String urlUserPhoto;
  String description;
  List<String> urlPhotos;
  DateTime dateTime;
  int curtidas;

  Post({
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
}
