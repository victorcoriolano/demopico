import 'dart:math';
import 'package:demopico/features/external/datasources/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/user/data/models/user.dart';
import 'package:demopico/features/user/data/services/auth_service.dart';
import 'package:demopico/features/user/data/services/database_service.dart';
import 'package:flutter/foundation.dart';

class HubService {
  static HubService? _instance;
  static HubService get instance {
    _instance ??= HubService();
    return _instance!;
  }

// Postar no hub
  Future<void> postHubCommuniqueToFirebase(String text, type) async {
    try {
      AuthService auth = AuthService();
      String? uid = auth.currentUser?.uid;
      String? name = auth.currentUser?.displayName;
      print('$uid, $name');
      if (name == null && uid == null) {
        if (kDebugMode) {
          print('erro em pegar name e uid do auth current user');
        }
      } else {
        DatabaseService dbService = DatabaseService();
        UserM? user = await dbService.getUserDetailsFromFirestore(uid);
        print(user.toString());
        if (user != null) {
          Firestore firelibrary = Firestore();
          FirebaseFirestore firestore = firelibrary.firestore;
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
