import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/external/datasources/firestore.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/hub/infra/interfaces/i_hub_repository.dart';
import 'package:demopico/features/hub/infra/repository/hub_repository.dart';
import 'package:demopico/features/user/data/models/user.dart';
import 'package:demopico/features/user/data/services/user_service.dart';
import 'package:flutter/foundation.dart';

class HubService {

  static HubService? _hubService;
  final UserService userService;
  final IHubRepository iHubRepository; 


  HubService({required this.userService, required this.iHubRepository});

   HubService get getInstance {
    _hubService ??= HubService(userService: userService, iHubRepository: HubRepository(firestore: Firestore()));
    return _hubService!;
  }

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
      await iHubRepository.createCommunique(newCommunique);
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
      return  await iHubRepository.listCommuniques();
    } catch (e) {
      Exception("Não foi possível pegar todos comunicados");
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }
}
