import 'package:demopico/features/user/domain/models/user.dart';

class Communique {
  final String id;
  final String uid;
  final String? pictureUrl;
  final String vulgo;
  final String text;
  final String timestamp;
  final int likeCount;
  final List<String> likedBy;
  final TypeCommunique type;

  Communique({
    required this.id,
    required this.uid,
    required this.vulgo,
    required this.text,
    required this.pictureUrl,
    required this.timestamp,
    required this.likeCount,
    required this.likedBy,
    required this.type,
  });

  factory Communique.initial(String content, TypeCommunique type, UserM user) {
    return Communique(
      id: '',
      uid: user.id,
      vulgo: user.name,
      text: content,
      pictureUrl: user.pictureUrl ?? '',
      timestamp: DateTime.now().toIso8601String(),
      likeCount: 0,
      likedBy: [],
      type: type,
    );
  }

  //converte doc em objeto
  factory Communique.fromJson(Map<String, dynamic> json, String id) {
    return Communique(
      id: id,
      uid: json['uid'],
      vulgo: json['vulgo'],
      text: json['text'],
      timestamp: json['timestamp'],
      pictureUrl: json['pictureUrl'],
      likeCount: json['likeCount'],
      likedBy: List<String>.from(json['likedBy'] ?? []),
      type: TypeCommunique.fromString(json['type']),
    );
  }

  //converte objeto em doc
  Map<String, dynamic> toJsonMap() {
    return {
      'id': id,
      'uid': uid,
      'vulgo': vulgo,
      'text': text,
      'pictureUrl': pictureUrl,
      'timestamp': timestamp,
      'likeCount': likeCount,
      'likedBy': likedBy,
      'type': type.name,
    };
  }
}

enum TypeCommunique {
  donation,
  event,
  normal,
  announcement;

  factory TypeCommunique.fromString(String type) {
    switch (type) {
      case 'donation':
        return TypeCommunique.donation;
      case 'event':
        return TypeCommunique.event;
      case 'normal':
        return TypeCommunique.normal;
      case 'announcement':
        return TypeCommunique.announcement;
      default:
        throw ArgumentError('Unknown type: $type');
    }
  }
}