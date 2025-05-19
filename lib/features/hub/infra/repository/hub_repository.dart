import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/hub/domain/interfaces/i_hub_repository.dart';
import 'package:demopico/features/hub/domain/interfaces/i_hub_service.dart';
import 'package:demopico/features/hub/infra/services/hub_service.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_auth_service.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/user_firebase_repository.dart';
import 'package:demopico/features/user/infra/services/user_auth_firebase_service.dart';
import 'package:flutter/foundation.dart';

class HubRepository implements IHubRepository {

  static HubRepository? _hubRepository;

  static HubRepository get getInstance{
    _hubRepository ??= HubRepository(userAuthServiceIMP: UserAuthFirebaseService.getInstance, hubServiceIMP: HubService.getInstance, userDatabaseRepositoryIMP: UserFirebaseRepository.getInstance);
    return _hubRepository!;
  }

  final IUserDatabaseRepository  userDatabaseRepositoryIMP;
  final IUserAuthService userAuthServiceIMP;
  final IHubService hubServiceIMP;

  HubRepository({
    required this.userDatabaseRepositoryIMP,
    required this.userAuthServiceIMP,
    required this.hubServiceIMP,
  });

  // Criar comunicado
  @override
  Future<void> postHubCommuniqueToFirebase(String text, dynamic type) async {
    try {
      String userID = userAuthServiceIMP.currentUser();
      UserM? user = await userDatabaseRepositoryIMP.getUserDetails(userID);
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
        await hubServiceIMP.createCommunique(newCommunique);
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
      return await hubServiceIMP.listCommuniques();
    } catch (e) {
      if (kDebugMode) print(e);
      return [];
    }
  }

  // Editar comunicado
  @override
  Future<void> updateCommunique(Communique communique) async {
    try {
      await hubServiceIMP.updateCommunique(communique);
    } catch (e) {
      if (kDebugMode) print('Erro ao atualizar comunicado: $e');
    }
  }

  // Deletar comunicado
  @override
  Future<void> deleteCommunique(String communiqueId) async {
    try {
      await hubServiceIMP.deleteCommunique(communiqueId);
    } catch (e) {
      if (kDebugMode) print('Erro ao deletar comunicado: $e');
    }
  }
}
