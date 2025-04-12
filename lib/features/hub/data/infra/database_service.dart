import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/user/data/models/user.dart';
import 'package:demopico/features/user/data/services/auth_service.dart';
import 'package:flutter/foundation.dart';

class HubService {
  static HubService? _instance;
  static HubService get instance {
    _instance ??= HubService();
    return _instance!;
  }

  FirebaseFirestore? _firestore;
  FirebaseFirestore get firestore {
    _firestore ??= FirebaseFirestore.instance;
    return _firestore!;
  }

  AuthService auth = AuthService();
////////////////////////////
////////////////////////////
////////////////////////////
  Future<void> addUserDetailsToFirestore({required UserM newUser}) async {
    String uid = newUser.id!;

    final mappedUser = newUser.toJsonMap();

    await firestore.collection('users').doc(uid).set(mappedUser);
  }

/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
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

//Serviço GET ID by USERNAME
  Future<String?> getIDByVulgo(
    String vulgo,
  ) async {
    QuerySnapshot idSnapshot = await firestore
        .collection("users_email_vulgo")
        .where('vulgo', isEqualTo: vulgo)
        .get();
    if (idSnapshot.docs.isNotEmpty) {
      return idSnapshot.docs.first.id;
    } else {
      return null;
    }
  }

  //Serviço GET EMAIL by ID
  Future<String?> getEmailByID(String id) async {
    DocumentSnapshot emailSnapshot =
        await firestore.collection("user_email_vulgo").doc(id).get();
    if (emailSnapshot.exists) {
      Map<String, dynamic>? data =
          emailSnapshot.data() as Map<String, dynamic>?;
      if (data != null && data.containsKey('email')) {
        return data['email'] as String;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }


////////////////
////////////////
// Postar no hub
  Future<void> postHubCommuniqueToFirebase(String text, type) async {
    try {
      String? uid = auth.currentUser?.uid;
      String? name = auth.currentUser?.displayName;
      print('$uid, $name');
      if (name == null && uid == null) {
        if (kDebugMode) {
          print('erro em pegar name e uid do auth current user');
        }
      } else {
        UserM? user = await getUserDetailsFromFirestore(uid);
        print(user.toString());
        if (user != null) {
          Communique newCommunique = Communique(
            id: Random(27345).toString(),
            uid: uid!,
            vulgo: user.name!,
            pictureUrl: user.pictureUrl ?? '',
            text: text,
            timestamp: DateTime.now().toString(),
            likeCount: 0,
            likedBy: [],
            type: type,
          );
          print(newCommunique);
          Map<String, dynamic> newPostMap = newCommunique.toJsonMap();
          print(newPostMap);
          await firestore.collection('communique').add(newPostMap);
        }
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.code);
        print(e.message);
        print(e.stackTrace);
      }
    }
  }
// Deletar do hub

// Pegar o hub
  Future<List<Communique>> getAllCommuniques() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('communique')
          .orderBy('timestamp', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => Communique.fromDocument(doc))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }
}
