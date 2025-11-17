
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
  final List<String> likedBy;
  final List<String> spotsIds; //spots linkados pode ser mais de um 
  final List<String> mentionedUsers;
  final DateTime dateTime;
  final int curtidas;
  final TypePost typePost;

  Post({
    required this.mentionedUsers,
    required this.profileRelated,
    required this.id,
    required this.nome,
    required this.userId,
    required this.spotID,
    required this.avatar,
    required this.description,
    required this.urlImages,
    required this.typePost,
    required this.spotsIds,
    required this.likedBy,
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
      profileRelated: json["profileRelated"] ?? "",
      spotsIds: List.from(json["spotsIds"] ?? []),
      mentionedUsers: List.from(json["mentionedUsers"] ?? []),
      likedBy: List.from(json["likedBy"] ?? []),
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
      'spotsIds': spotsIds,
      'mentionedUsers': mentionedUsers,
      'likedBy': likedBy,
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
    List<String>? spotsIds,
    List<String>? mentionedUsers,
    List<String>? likedBy,
  }) {
    return Post(
      mentionedUsers: mentionedUsers ?? this.mentionedUsers,
      likedBy: likedBy ?? this.likedBy ,
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
      spotsIds: spotsIds ?? this.spotsIds,
    );
  }  

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Post &&
      other.id == id &&
      other.nome == nome &&
      other.userId == userId &&
      other.spotID == spotID &&
      other.avatar == avatar &&
      other.description == description &&
      other.urlImages == urlImages &&
      other.urlVideos == urlVideos &&
      other.dateTime == dateTime &&
      other.curtidas == curtidas &&
      other.typePost == typePost &&
      other.profileRelated == profileRelated &&
      other.spotsIds == spotsIds &&
      other.mentionedUsers == mentionedUsers &&
      other.likedBy == likedBy;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      nome,
      userId,
      spotID,
      avatar,
      description,
      urlImages,
      urlVideos,
      dateTime,
      curtidas,
      typePost,
      profileRelated,
      spotsIds,
      mentionedUsers,
      likedBy,
    );
  }
}
