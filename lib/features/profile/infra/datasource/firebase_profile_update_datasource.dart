import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/external/datasources/firebase/firestore.dart';
import 'package:demopico/features/mapa/data/mappers/firebase_errors_mapper.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_update_datasource.dart';

class FirebaseProfileUpdateDatasource implements IProfileUpdateDatasource {
  static FirebaseProfileUpdateDatasource? _firebaseProfileUpdateDatasource;

  static FirebaseProfileUpdateDatasource get getInstance {
    _firebaseProfileUpdateDatasource ??=
        FirebaseProfileUpdateDatasource(firestore: Firestore.getInstance);
    return _firebaseProfileUpdateDatasource!;
  }

  FirebaseProfileUpdateDatasource({required this.firestore});
  final FirebaseFirestore firestore;

  @override
  Future<void> updateBio(String newBio, String uid) async {
    try {
      await firestore
        .collection('users')
        .doc(uid)
        .update({'description': newBio});
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    }on Exception catch (e){
      throw UnknownFailure(originalException: e);
    }catch (e){
      throw UnknownFailure(unknownError: e);
    }
    
  }


  @override
  Future<void> updateContributions(String uid) async {
    try {
      await firestore.collection('users').doc(uid).update({
        'picosAdicionados': FieldValue.increment(1),
      });
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    } on Exception catch (e) {
      throw UnknownFailure(originalException: e);
    } catch (e) {
      throw UnknownFailure(unknownError: e);
    }
  }


  @override
  Future<void> updatePhoto(String newImg, String uid) async {
    try {
      await firestore.collection('users').doc(uid).update({'pictureUrl': newImg});
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    } on Exception catch (e) {
      throw UnknownFailure(originalException: e);
    } catch (e) {
      throw UnknownFailure(unknownError: e);
    }
  }

  @override
  Future<void> updateFollowers(String uid) async {
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .update({'conexoes': FieldValue.increment(1)});
    } on FirebaseException catch (e) {
      throw FirebaseErrorsMapper.map(e);
    } on Exception catch (e) {
      throw UnknownFailure(originalException: e);
    } catch (e) {
      throw UnknownFailure(unknownError: e);
    }
  }
}
