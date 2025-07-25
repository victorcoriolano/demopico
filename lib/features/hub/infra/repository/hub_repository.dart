import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/hub/domain/interfaces/i_hub_repository.dart';
import 'package:demopico/features/hub/domain/interfaces/i_hub_service.dart';
import 'package:demopico/features/hub/infra/services/hub_service.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_auth_service.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:demopico/features/user/infra/datasource/remote/firebase_auth_service.dart';
import 'package:flutter/foundation.dart';

class HubRepository implements IHubRepository {
  static HubRepository? _hubRepository;

  static HubRepository get getInstance {
    _hubRepository ??= HubRepository(
        userAuthServiceIMP: FirebaseAuthService.getInstance,
        hubServiceIMP: HubService.getInstance,
        userDatabaseRepositoryIMP: UserDataRepositoryImpl.getInstance);
    return _hubRepository!;
  }

  final IUserDataRepository userDatabaseRepositoryIMP;
  final IUserAuthService userAuthServiceIMP;
  final IHubService hubServiceIMP;

  HubRepository({
    required this.userDatabaseRepositoryIMP,
    required this.userAuthServiceIMP,
    required this.hubServiceIMP,
  });

  // Criar comunicado
  @override
  Future<Communique> postHubCommuniqueToFirebase(String text, dynamic type) async {
    try {
      String? userID = userAuthServiceIMP.currentIdUser;

      if(userID == null) throw InvalidUserFailure();

      UserM user = await userDatabaseRepositoryIMP.getUserDetailsByID(userID);
      final id = FirebaseFirestore.instance.collection('comunicados').doc().id;

      
        final newCommunique = Communique(
          id: id,
          uid: user.id,
          vulgo: user.name,
          pictureUrl: user.pictureUrl ?? '',
          text: text,
          timestamp: DateTime.now().toString(),
          likeCount: 0,
          likedBy: [],
          type: type,
        );
        await hubServiceIMP.createCommunique(newCommunique);
        return newCommunique;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.code);
        print(e.message);
        print(e.stackTrace);
      }
      throw UnimplementedError('Erro ao criar comunicado: ${e.message}');
    } on Failure catch (e) {
      debugPrint("HUB-REP: ERRO AO CRIAR COMUNICADO: $e");
      rethrow;
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
