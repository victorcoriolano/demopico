import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/external/datasources/firestore.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/hub/infra/interfaces/i_hub_repository.dart';
import 'package:demopico/features/hub/infra/interfaces/i_hub_service.dart';
import 'package:demopico/features/hub/infra/services/hub_service.dart';
import 'package:demopico/features/user/data/services/user_service.dart';
import 'package:flutter/foundation.dart';

class HubRepository implements IHubRepository {

  static HubRepository? _hubRepository;

  static HubRepository get getInstance{
    _hubRepository ??= HubRepository(userService: UserService.getInstance, iHubService: HubService(firestore: Firestore()   ).getInstance);
    return _hubRepository!;
  }

  final UserService userService;
  final IHubService iHubService;

  HubRepository({
    required this.userService,
    required this.iHubService,
  });

  // Criar comunicado
  @override
  Future<void> postHubCommuniqueToFirebase(String text, dynamic type) async {
    try {
      final user = await userService.getCurrentUser();
      final id = FirebaseFirestore.instance.collection('comunicados').doc().id;

      if (user != null) {
        final newCommunique = Communique(
          id: id,
          uid: user.id!,
          vulgo: user.name!,
          pictureUrl: user.pictureUrl ?? '',
          text: text,
          timestamp: DateTime.now().toString(),
          likeCount: 0,
          likedBy: [],
          type: type,
        );
        await iHubService.createCommunique(newCommunique);
      } else {
        if (kDebugMode) print('Usuário não encontrado.');
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.code);
        print(e.message);
        print(e.stackTrace);
      }
    }
  }

  // Listar comunicados
  @override
  Future<List<Communique>> getAllCommuniques() async {
    try {
      return await iHubService.listCommuniques();
    } catch (e) {
      if (kDebugMode) print(e);
      return [];
    }
  }

  // Editar comunicado
  @override
  Future<void> updateCommunique(Communique communique) async {
    try {
      await iHubService.updateCommunique(communique);
    } catch (e) {
      if (kDebugMode) print('Erro ao atualizar comunicado: $e');
    }
  }

  // Deletar comunicado
  @override
  Future<void> deleteCommunique(String communiqueId) async {
    try {
      await iHubService.deleteCommunique(communiqueId);
    } catch (e) {
      if (kDebugMode) print('Erro ao deletar comunicado: $e');
    }
  }
}
