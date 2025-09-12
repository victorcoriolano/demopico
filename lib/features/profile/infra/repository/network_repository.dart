import 'package:demopico/core/common/mappers/i_mapper_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/profile/domain/interfaces/i_network_datasource.dart';
import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/infra/datasource/firebase_network_datasource.dart';
import 'package:demopico/features/profile/infra/datasource/mappers/relationship_mapper.dart';
import 'package:demopico/features/profile/presentation/view_objects/relationship_vo.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:flutter/widgets.dart';

class NetworkRepository implements INetworkRepository {
  final INetworkDatasource<FirebaseDTO> _datasource;
  final RelationshipMapper _mapperRelationship;

  NetworkRepository({required RelationshipMapper mapperConnection, required INetworkDatasource<FirebaseDTO> datasource})
      : _datasource = datasource, _mapperRelationship = mapperConnection;

  static NetworkRepository? _instance;

  static NetworkRepository get instance => _instance ??=
      NetworkRepository(datasource: FirebaseNetworkDatasource.instance, mapperConnection: RelationshipMapper.instance);

  final IMapperDto<UserM, FirebaseDTO> _mapperDtoUser = FirebaseDtoMapper<UserM>(
    fromJson: (Map<String, dynamic> map, String id) => UserM.fromJson(map, id), 
    toMap: (UserM model) => model.toJsonMap(), 
    getId: (UserM model) => model.id
  );

  final IMapperDto<Relationship, FirebaseDTO> _mapperDtoConnection = FirebaseDtoMapper<Relationship>(
    fromJson: (Map<String, dynamic> map, String id) => Relationship.fromJson(map, id), 
    toMap: (Relationship model) => model.toJson(), 
    getId: (Relationship model) => model.id
  );

  

  IMapperDto<UserM, FirebaseDTO> get mapperUser => _mapperDtoUser;

  IMapperDto<Relationship, FirebaseDTO> get mapperDtoConnection => _mapperDtoConnection;


  
  @override
  Future<Relationship> createRelationship(Relationship connection) {
    return _datasource.createConnection(mapperDtoConnection.toDTO(connection)).then((dto) {
      return mapperDtoConnection.toModel(dto);
    });
  }
  
  @override
  Future<void> deleteRelationship(RelationshipVo connection) {
    Relationship dto = _mapperRelationship.toModel(connection);
    return _datasource.deleteConnection(mapperDtoConnection.toDTO(dto));
  }

  
  
  @override
  Future<List<Relationship>> getRelationshipAccepted(String userID) {
    return _datasource.getRelationships(
      fieldRequest: "requesterUserID.id",
      valueID: userID,
      fieldOther: "status",
      valorDoStatus: RequestConnectionStatus.accepted.name,
    ).then((dtos) {
      debugPrint("DTOs recebidos: ${dtos.length}");
      return dtos.map((dto) => mapperDtoConnection.toModel(dto)).toList();
    });
  }
  
  
  @override
  Future<List<Relationship>> getRelationshipRequests(String userID) {
    return _datasource.getRelationships(
      fieldRequest: "addresseeID.id",
      valueID: userID,
      fieldOther: "status",
      valorDoStatus: RequestConnectionStatus.pending.name,
    ).then((dtos) {
      debugPrint("DTOs recebidos: ${dtos.length}");
      return dtos.map((dto) => mapperDtoConnection.toModel(dto)).toList();
    });
  }
  
  @override
  Future<List<Relationship>> getRelationshipSent(String userID) {
    return _datasource.getRelationships(
      fieldRequest: "requesterUserID.id",
      valueID: userID,
      fieldOther: "status",
      valorDoStatus: RequestConnectionStatus.pending.name,
    ).then((dtos) {
      debugPrint("DTOs recebidos: ${dtos.length}");
      return dtos.map((dto) => mapperDtoConnection.toModel(dto)).toList();
    });
  }
  
  @override
  Future<Relationship> updateRelationship(RelationshipVo connection) {
    Relationship dto = _mapperRelationship.toModel(connection);

    return _datasource.updateConnection(mapperDtoConnection.toDTO(dto)).then((dto) {
      return mapperDtoConnection.toModel(dto);
    });
  }
  
}
