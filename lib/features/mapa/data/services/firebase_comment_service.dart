import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/mapa/domain/entities/comment.dart';
import 'package:demopico/features/mapa/domain/interfaces/i_comment_repository.dart';
import 'package:demopico/features/mapa/domain/models/comment_model.dart';

class FirebaseCommentService implements ICommentRepository {
  static FirebaseCommentService? _firebaseCommentService;
  static FirebaseCommentService get getInstance {
    _firebaseCommentService ??= FirebaseCommentService(firebaseFirestore: FirebaseFirestore.instance);
    return _firebaseCommentService!;
  }

  final FirebaseFirestore firebaseFirestore;

  FirebaseCommentService({required this.firebaseFirestore});

  @override
  Future<CommentModel> addComment(Comment comment) async {
    final ref = await firebaseFirestore
        .collection('comments')
        .add(CommentModel.fromEntity(comment).toJson());
    return ref.get().then((doc) {
      return CommentModel.fromJson(doc.data()!, doc.id);
    });
  }

  @override
  Future<List<CommentModel>> getCommentsByPeak(String peakId) async {
    final querySnapshot = await firebaseFirestore
        .collection('comments')
        .where('peakId', isEqualTo: peakId)
        .orderBy('timestamp', descending: true)
        .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return CommentModel.fromJson(data, doc.id);
    }).toList();
  }

  @override
  Future<void> deleteComment(String commentId) async {
    final ref = firebaseFirestore.collection('comments').doc(commentId);
    return await ref.delete();
  }

  @override
  Future<CommentModel> updateComment(CommentModel comment) async {
    final ref = firebaseFirestore.collection('comments').doc(comment.id);
    return await ref.update(comment.toJson()).then((onValue) => comment);
  }
}
