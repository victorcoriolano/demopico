import 'package:demopico/core/common/files_manager/models/file_model.dart';

class Post {
  String id;
  String nome;     
  String userId;
  String spotID;             
  String urlUserPhoto;
  String description;
  List<String> urlImages;
  List<String>? urlVideos;
  DateTime dateTime;
  int curtidas;
  List<FileModel>? files;

  Post({
    required this.id,
    required this.nome,
    required this.userId,
    required this.spotID,
    required this.urlUserPhoto,
    required this.description,
    required this.urlImages,
    DateTime? dateTime,
    int? curtidas,
    this.files,
    this.urlVideos,
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
    return urlImages;
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
    urlImages = value;
  }

  void setCurtidas(int value) {
    curtidas = value;
  }

  void setFiles(List<FileModel> value) {
    files = value;
  }

  factory Post.fromJson(Map<String, dynamic> json, String id) {
    return Post(
      id: id,
      nome: json['nome'],
      spotID: json['spotID'] ?? '', 
      userId: json['userId'],
      urlUserPhoto: json['urlUserPhoto'],
      description: json['description'],
      urlImages: List<String>.from(json['urlMidia']),
      urlVideos: json['urlVideos'] != null
          ? List<String>.from(json['urlVideos'])
          : null,
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
      'urlMidia': urlImages,
      'urlVideos': urlVideos ?? [],
      'dateTime': dateTime.toIso8601String(),
      'curtidas': curtidas,
    };
  }

  
}
