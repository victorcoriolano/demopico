import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/user/data/models/user.dart';
import 'package:demopico/features/user/data/services/auth_service.dart';
import 'package:flutter/foundation.dart';

class UserService {
  FirebaseFirestore? _firestore;
  FirebaseFirestore get firestore {
    _firestore ??= FirebaseFirestore.instance;
    return _firestore!;
  }

  final AuthService auth = AuthService();

  Future<UserM?> getCurrentUser() async {
    String? uid = auth.currentUser?.uid;
    if (uid == null) return null;
    return getUserDetailsFromFirestore(uid);
  }

  Future<UserM?> getUserDetailsFromFirestore(String? uid) async {
    try {
      DocumentSnapshot userSnapshot =
          await firestore.collection('users').doc(uid).get();

      if (userSnapshot.exists) {
        return UserM.fromDocument(userSnapshot);
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.code);
        print(e.message);
        print(e.stackTrace);
      }
    }
    return null;
  }
}
