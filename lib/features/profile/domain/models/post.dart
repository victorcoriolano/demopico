
import 'package:demopico/features/user/domain/enums/type_post.dart';

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
  TypePost typePost;

  Post({
    required this.id,
    required this.nome,
    required this.userId,
    required this.spotID,
    required this.urlUserPhoto,
    required this.description,
    required this.urlImages,
    required this.typePost,
    DateTime? dateTime,
    int? curtidas,
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
      typePost: TypePost.fromString(json["typePost"]),
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
      'typePost': typePost.name
    };
  }

  Post copyWith({
    String? id,
    String? nome,
    String? userId,
    String? spotID,
    String? urlUserPhoto,
    String? description,
    List<String>? urlImages,
    List<String>? urlVideos,
    DateTime? dateTime,
    int? curtidas,
    TypePost? typePost,
  }) {
    return Post(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      userId: userId ?? this.userId,
      spotID: spotID ?? this.spotID,
      urlUserPhoto: urlUserPhoto ?? this.urlUserPhoto,
      description: description ?? this.description,
      urlImages: urlImages ?? this.urlImages,
      urlVideos: urlVideos ?? this.urlVideos,
      dateTime: dateTime ?? this.dateTime,
      curtidas: curtidas ?? this.curtidas,
      typePost: typePost ?? this.typePost,
    );
  }  
}
