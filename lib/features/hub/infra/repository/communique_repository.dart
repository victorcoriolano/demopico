import 'package:demopico/core/common/auth/domain/interfaces/i_auth_repository.dart';
import 'package:demopico/core/common/auth/domain/interfaces/i_user_repository.dart';
import 'package:demopico/core/common/auth/infra/repositories/firebase_auth_repository.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/core/common/mappers/i_mapper_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/hub/domain/interfaces/i_communique_repository.dart';
import 'package:demopico/features/hub/domain/interfaces/i_hub_service.dart';
import 'package:demopico/features/hub/infra/services/hub_service.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:flutter/foundation.dart';

class CommuniqueRepository implements ICommuniqueRepository {
  static CommuniqueRepository? _instance;

  static CommuniqueRepository get getInstance {
    _instance ??= CommuniqueRepository(
        userAuthServiceIMP: FirebaseAuthRepository.instance,
        hubServiceIMP: HubService.getInstance,
        userDatabaseRepositoryIMP: UserDataRepositoryImpl.getInstance);
    return _instance!;
  }

  final IUserRepository userDatabaseRepositoryIMP;
  final IAuthRepository userAuthServiceIMP;
  final IHubService hubServiceIMP;

  CommuniqueRepository({
    required this.userDatabaseRepositoryIMP,
    required this.userAuthServiceIMP,
    required this.hubServiceIMP,
  });
  final IMapperDto<Communique, FirebaseDTO> _mapper =
      FirebaseDtoMapper<Communique>(
    fromJson: (data, id) => Communique.fromJson(data, id),
    toMap: (model) => model.toJsonMap(),
    getId: (model) => model.id,
  );

  

  @override
  Future<void> updateCommunique(Communique communique) async {
    try {
      await hubServiceIMP.update(communique);
    }on Failure catch (e) {
      debugPrint("HUB-REPO: ERRO CONHECIDO - $e");
      rethrow;
    } catch (e) {
      throw UnknownFailure(unknownError: e.toString());
    }
  }

  @override
  Future<void> deleteCommunique(String communiqueId) async {
    try {
      await hubServiceIMP.delete(communiqueId);
    } on Failure catch (e) {
      debugPrint("HUB-REPO: ERRO CONHECIDO - ${e.runtimeType} - $e");
      rethrow;
    } catch (e) {
      throw UnknownFailure(unknownError: e.toString());
    }
  }
  
  @override
  Future<Communique> postHubCommuniqueToDataSource(Communique communique) async {
    final firebaseDTO = _mapper.toDTO(communique);
    final dto = await hubServiceIMP.create(firebaseDTO);
    return _mapper.toModel(dto);
  }
  
  @override
  Stream<List<Communique>> watchCommuniques() {
    return hubServiceIMP.list().map((dtos) {
      return dtos.map((dto) => _mapper.toModel(dto)).toList();
    });
  }
  
  @override
  
  Future<List<Communique>> get recentCommunique {
    return hubServiceIMP.list().map((dtos) {
      return dtos.map((dto) => _mapper.toModel(dto)).toList();
    }).first;
  }
}
