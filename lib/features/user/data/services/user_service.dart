import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/external/datasources/firestore.dart';
import 'package:demopico/features/user/data/models/user.dart';
import 'package:demopico/features/user/data/services/auth_service.dart';
import 'package:flutter/foundation.dart';

class UserService {

  static UserService? _userService;
  final Firestore firestore;

  //falta transforme vc como isntancia unica 
  final AuthService auth = AuthService();

  UserService get getInstance{
    _userService ??= UserService(firestore: firestore); 
    return _userService!;
  }

  UserService({required this.firestore});


  Future<UserM?> getCurrentUser() async {
    String? uid = auth.currentUser?.uid;
    if (uid == null) return null;
    return getUserDetailsFromFirestore(uid);
  }

  Future<UserM?> getUserDetailsFromFirestore(String? uid) async {
    try {
      DocumentSnapshot userSnapshot =
          await firestore.getInstance.collection('users').doc(uid).get();

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
