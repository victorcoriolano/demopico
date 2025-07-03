import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/mapa/data/data_sources/interfaces/i_comment_spot_datasource.dart';
import 'package:demopico/core/common/files/dtos/firebase_dto.dart';
import 'package:demopico/features/mapa/data/mappers/firebase_errors_mapper.dart';

class FirebaseCommentRemoteDataSource implements ICommentSpotDataSource {
  static FirebaseCommentRemoteDataSource? _firebaseCommentRemoteDataSource;
  static FirebaseCommentRemoteDataSource get getInstance {
    _firebaseCommentRemoteDataSource ??= FirebaseCommentRemoteDataSource(firebaseFirestore: FirebaseFirestore.instance);
    return _firebaseCommentRemoteDataSource!;
  }

  final FirebaseFirestore firebaseFirestore;

  FirebaseCommentRemoteDataSource({required this.firebaseFirestore});

  @override
  Future<FirebaseDTO> create(FirebaseDTO comment) async {
    try {
      final ref =
          await firebaseFirestore.collection('comments').add(comment.data);
      return comment.copyWith(id: ref.id);
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    } catch (e, stacktrace) {
      throw UnknownFailure(
          originalException: e as Exception, stackTrace: stacktrace);
    }
  }

  @override
  Future<List<FirebaseDTO>> getBySpotId(String peakId) async {
    final querySnapshot = await firebaseFirestore
        .collection('comments')
        .where('peakId', isEqualTo: peakId)
        .orderBy('timestamp', descending: true)
        .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return FirebaseDTO(id: doc.id, data: data);
    }).toList();
  }

  @override
  Future<void> delete(String commentId) async {
    final ref = firebaseFirestore.collection('comments').doc(commentId);
    return await ref.delete();
  }

  @override
  Future<void> update(FirebaseDTO comment) async {    
    await firebaseFirestore.collection("comments").doc(comment.id).update(comment.data);
  }
}
