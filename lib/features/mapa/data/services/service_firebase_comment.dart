import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/mapa/domain/entities/comment.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_comment_repository.dart';

class ServiceFirebaseComment implements ICommentRepository{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addComment(Comment comment) async {
    await _firestore.collection('comments').add({
      'peakId': comment.peakId,
      'userId': comment.userId,
      'content': comment.content,
      'timestamp': comment.timestamp.toIso8601String(),
    });
  }

  @override
  Future<List<Comment>> getCommentsByPeak(String peakId) async {
    final querySnapshot = await _firestore
        .collection('comments')
        .where('peakId', isEqualTo: peakId)
        .orderBy('timestamp', descending: true)
        .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return Comment(
        id: doc.id,
        peakId: data['peakId'],
        userId: data['userId'],
        content: data['content'],
        timestamp: DateTime.parse(data['timestamp']),
      );
    }).toList();
  }
}
