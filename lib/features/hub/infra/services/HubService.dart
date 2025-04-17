import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/external/datasources/firestore.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/hub/infra/repository/HubRepository.dart';
import 'package:demopico/features/user/data/models/user.dart';
import 'package:demopico/features/user/data/services/userService.dart';
import 'package:flutter/foundation.dart';

class HubService {

  final UserService userService;
  final HubRepository hubRepository; 
  
  static HubService? _instance;

  HubService({required this.userService, required this.hubRepository});

  static HubService get instance {
    _instance ??= HubService(userService: UserService(), hubRepository: HubRepository(firestore: Firestore()));
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
      await hubRepository.createCommunique(newCommunique);
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
