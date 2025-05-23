import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/external/datasources/firestore.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_update_service.dart';

class FirebaseProfileUpdateDatasource implements IProfileDatabaseUpdateService {
  static FirebaseProfileUpdateDatasource? _firebaseProfileUpdateDatasource;

  static FirebaseProfileUpdateDatasource get getInstance {
    _firebaseProfileUpdateDatasource ??=
        FirebaseProfileUpdateDatasource(firestore: Firestore.getInstance);
    return _firebaseProfileUpdateDatasource!;
  }

  FirebaseProfileUpdateDatasource({required this.firestore});
  final FirebaseFirestore firestore;

  @override
  void updateBio(String newBio, String uid) async {
    await firestore
        .collection('users')
        .doc(uid)
        .update({'description': newBio});
  }

  @override
  void updateContributions(String uid) async {
    await firestore.collection('users').doc(uid).update({
      'picosAdicionados': FieldValue.increment(1),
    });
  }

  @override
  void updatePhoto(String newImg, String uid) async {
    await firestore.collection('users').doc(uid).update({'pictureUrl': newImg});
  }

  @override
  void updateFollowers(String uid) async {
    await firestore
        .collection('users')
        .doc(uid)
        .update({'conexoes': FieldValue.increment(1)});
  }
}
