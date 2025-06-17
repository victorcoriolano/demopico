import 'package:demopico/features/profile/domain/models/post.dart';

class PostDTO {
  final String nome;
  final String userId;
  final String postId;
  final String urlUserPhoto;
  final String description;
  final List<String> urlPhotos;
  final DateTime dateTime;
  final int curtidas;

  PostDTO({
    required this.nome,
    required this.userId,
    required this.postId,
    required this.urlUserPhoto,
    required this.description,
    required this.urlPhotos,
    required this.dateTime,
    required this.curtidas,
  });

  factory PostDTO.fromJson(Map<String, dynamic> json) {
    return PostDTO(
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

  Post toModel() {
    return Post(
      id: '',
      nome: nome,
      userId: userId,
      postId: postId,
      urlUserPhoto: urlUserPhoto,
      description: description,
      urlPhotos: urlPhotos,
      dateTime: dateTime,
      curtidas: curtidas,
    );
  }

  static PostDTO fromModel(Post post) {
    return PostDTO(
      nome: post.nome,
      userId: post.userId,
      postId: post.postId,
      urlUserPhoto: post.urlUserPhoto,
      description: post.description,
      urlPhotos: post.urlPhotos,
      dateTime: post.dateTime,
      curtidas: post.curtidas,
    );
  }
}
