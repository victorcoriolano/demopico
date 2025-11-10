import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/mapa/domain/entities/comment.dart';

class  CommentModel extends Comment{
    final String id;

  CommentModel({
    required this.id,
    required super.userIdentification,
    required super.picoId,
    required super.content,
    required super.timestamp,
  });

  factory CommentModel.fromEntity(Comment comment) {
    return CommentModel(
      id: '',
      userIdentification: comment.userIdentification,
      picoId: comment.picoId,
      content: comment.content,
      timestamp: comment.timestamp,
    );
  }

  
  factory CommentModel.fromJson(Map<String, dynamic> json, String id) {
    return CommentModel(
      id: id,
      userIdentification: UserIdentification.fromJson(json['userIdentification']),
      picoId: json['picoId'],
      content: json['content'],
      timestamp: DateTime.parse (json['timestamp']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userIdentification': userIdentification.toJson(),
      'picoId': picoId,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  CommentModel copyWith({
    String? id,
    UserIdentification? userIdentification,
    String? picoId,
    String? content,
    DateTime? timestamp,
  }){
    return CommentModel(
      id: id ?? this.id,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp, 
      userIdentification: userIdentification ?? this.userIdentification,
      picoId: picoId ?? this.picoId,
    );
  }
}