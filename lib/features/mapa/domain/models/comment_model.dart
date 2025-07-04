import 'package:demopico/features/mapa/domain/entities/comment.dart';

class CommentModel extends Comment{
    final String id;

  CommentModel({
    required this.id,
    required super.peakId,
    required super.userId,
    required super.content,
    required super.timestamp,
  });

  factory CommentModel.fromEntity(Comment comment) {
    return CommentModel(
      id: '',
      peakId: comment.peakId,
      userId: comment.userId,
      content: comment.content,
      timestamp: comment.timestamp,
    );
  }

  
  factory CommentModel.fromJson(Map<String, dynamic> json, String id) {
    return CommentModel(
      id: id,
      peakId: json['peakId'],
      userId: json['userId'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'peakId': peakId,
      'userId': userId,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  CommentModel copyWith({
    String? id,
    String? peakId,
    String? userId,
    String? content,
    DateTime? timestamp,
  }){
    return CommentModel(
      id: id ?? this.id,
      peakId: peakId ?? this.peakId,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}