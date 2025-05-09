import 'package:cloud_firestore/cloud_firestore.dart';

class Communique {
  final String id;
  final String uid;
  final String? pictureUrl;
  final String vulgo;
  final String text;
  final String timestamp;
  int likeCount;
  final List<String> likedBy;
  final String type;

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

  //converte doc em objeto
  factory Communique.fromDocument(DocumentSnapshot doc) {
    return Communique(
      id: doc.id,
      uid: doc['uid'],
      vulgo: doc['vulgo'],
      text: doc['text'],
      timestamp: doc['timestamp'],
      pictureUrl: doc['pictureUrl'],
      likeCount: doc['likeCount'],
      likedBy: List<String>.from(doc['likedBy'] ?? []),
      type: doc['type'],
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
      'type': type,
    };
  }
}
