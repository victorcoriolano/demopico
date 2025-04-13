import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/user/data/models/user.dart';
import 'package:demopico/features/user/data/services/userService.dart';
import 'package:flutter/foundation.dart';

class HubService {
  final UserService userService = UserService();
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

  
////////////////
////////////////
// Postar no hub
 Future<void> postHubCommuniqueToFirebase(String text, type) async {
  try {
    UserM? user = await userService.getCurrentUser();
    if (user != null) {
      Communique newCommunique = Communique(
        id: Random(27345).toString(),
        uid: user.id!,
        vulgo: user.name!,
        pictureUrl: user.pictureUrl ?? '',
        text: text,
        timestamp: DateTime.now().toString(),
        likeCount: 0,
        likedBy: [],
        type: type,
      );
      await firestore.collection('communique').add(newCommunique.toJsonMap());
    } else {
      if (kDebugMode) {
        print('Usuário não encontrado.');
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
