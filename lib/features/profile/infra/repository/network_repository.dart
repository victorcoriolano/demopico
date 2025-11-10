import 'package:demopico/core/common/mappers/i_mapper_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/profile/domain/interfaces/i_network_datasource.dart';
import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/infra/datasource/firebase_network_datasource.dart';
import 'package:demopico/features/user/domain/models/user_model.dart';
import 'package:flutter/widgets.dart';

class NetworkRepository implements INetworkRepository {
  final INetworkDatasource<FirebaseDTO> _datasource;

  NetworkRepository({required INetworkDatasource<FirebaseDTO> datasource})
      : _datasource = datasource;

  static NetworkRepository? _instance;

  static NetworkRepository get instance => _instance ??=
      NetworkRepository(datasource: FirebaseNetworkDatasource.instance);

  final IMapperDto<UserM, FirebaseDTO> _mapperDtoUser = FirebaseDtoMapper<UserM>(
    fromJson: (Map<String, dynamic> map, String id) => UserM.fromJson(map, id), 
    toMap: (UserM model) => model.toJson(), 
    getId: (UserM model) => model.id
  );

  final IMapperDto<Relationship, FirebaseDTO> _mapperDtoConnection = FirebaseDtoMapper<Relationship>(
    fromJson: (Map<String, dynamic> map, String id) => Relationship.fromJson(map, id), 
    toMap: (Relationship model) => model.toJson(), 
    getId: (Relationship model) => model.id
  );

  IMapperDto<UserM, FirebaseDTO> get mapperUser => _mapperDtoUser;

  IMapperDto<Relationship, FirebaseDTO> get mapperConnection => _mapperDtoConnection;


  
  @override
  Future<Relationship> createRelationship(Relationship connection) {
    return _datasource.createConnection(mapperConnection.toDTO(connection)).then((dto) {
      return mapperConnection.toModel(dto);
    });
  }
  
  @override
  Future<void> deleteRelationship(String id) {
    return _datasource.deleteConnection(id);
  }
  
  @override
  Future<List<Relationship>> getRelationshipAccepted(String userID) {
    return _datasource.getAcceptedRelationships(idUser: userID
    ).then((dtos) {
      debugPrint("DTOs recebidos - relacionamentos aceitos: ${dtos.length}");
      return dtos.map((dto) => mapperConnection.toModel(dto)).toList();
    });
  }
  
  
  @override
  Future<List<Relationship>> getRelationshipRequests(String userID) {
    return _datasource.getRelactionships(
      fieldRequest: "addressedID",
      valueID: userID,
      fieldOther: "status",
      valorDoStatus: RequestConnectionStatus.pending.name,
    ).then((dtos) {
      debugPrint("DTOs recebidos - que o user requisitou: ${dtos.length}");
      return dtos.map((dto) => mapperConnection.toModel(dto)).toList();
    });
  }
  
  @override
  Future<List<Relationship>> getRelationshipSent(String userID) {
    return _datasource.getRelactionships(
      fieldRequest: "requesterUserID",
      valueID: userID,
      fieldOther: "status",
      valorDoStatus: RequestConnectionStatus.pending.name,
    ).then((dtos) {
      debugPrint("DTOs recebidos relacionamentos que o user enviou: ${dtos.length}");
      return dtos.map((dto) => mapperConnection.toModel(dto)).toList();
    });
  }
  
  @override
  Future<Relationship> updateRelationship(Relationship connection) {
    return _datasource.updateConnection(mapperConnection.toDTO(connection)).then((dto) {
      return mapperConnection.toModel(dto);
    });
  }
}
