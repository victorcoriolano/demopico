
import 'package:demopico/features/user/domain/enums/type_post.dart';


// TODO: COLOCAR USERIDENTIFICATION 
class Post {
  final String id;
  final String nome;     
  final String userId;
  final String spotID;             
  final String? avatar;
  final String description;
  final String profileRelated;
  final List<String> urlImages;
  final List<String>? urlVideos;
  final DateTime dateTime;
  final int curtidas;
  final TypePost typePost;

  Post({
    required this.profileRelated,
    required this.id,
    required this.nome,
    required this.userId,
    required this.spotID,
    required this.avatar,
    required this.description,
    required this.urlImages,
    required this.typePost,
    DateTime? dateTime,
    int? curtidas,
    this.urlVideos,
  })  : dateTime = dateTime ?? DateTime.now(),
        curtidas = curtidas ?? 0;



  factory Post.fromJson(Map<String, dynamic> json, String id) {
    return Post(
      id: id,
      nome: json['nome'],
      spotID: json['spotID'] ?? '', 
      userId: json['userId'],
      avatar: json['urlUserPhoto'],
      description: json['description'],
      urlImages: List<String>.from(json['urlMidia']),
      urlVideos: json['urlVideos'] != null
          ? List<String>.from(json['urlVideos'])
          : null,
      dateTime: DateTime.parse(json['dateTime']),
      curtidas: json['curtidas'],
      typePost: TypePost.fromString(json["typePost"]),
      profileRelated: json["profileRelated"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'userId': userId,
      'spotId': spotID,
      'urlUserPhoto': avatar,
      'description': description,
      'urlMidia': urlImages,
      'urlVideos': urlVideos ?? [],
      'dateTime': dateTime.toIso8601String(),
      'curtidas': curtidas,
      'typePost': typePost.name,
      'profileRelated': profileRelated,
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
    String? profileRelated,
  }) {
    return Post(
      profileRelated: profileRelated ?? this.profileRelated,
      id: id ?? this.id,
      nome: nome ?? this.nome,
      userId: userId ?? this.userId,
      spotID: spotID ?? this.spotID,
      avatar: urlUserPhoto ?? avatar,
      description: description ?? this.description,
      urlImages: urlImages ?? this.urlImages,
      urlVideos: urlVideos ?? this.urlVideos,
      dateTime: dateTime ?? this.dateTime,
      curtidas: curtidas ?? this.curtidas,
      typePost: typePost ?? this.typePost,
    );
  }  
}
