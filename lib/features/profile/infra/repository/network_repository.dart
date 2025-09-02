import 'package:demopico/core/common/files_manager/mappers/i_mapper_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/profile/domain/interfaces/i_network_datasource.dart';
import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/infra/datasource/firebase_network_datasource.dart';
import 'package:demopico/features/user/domain/models/user.dart';

class NetworkRepository implements INetworkRepository {
  final INetworkDatasource<FirebaseDTO> _datasource;

  NetworkRepository({required INetworkDatasource<FirebaseDTO> datasource})
      : _datasource = datasource;

  static NetworkRepository? _instance;

  static NetworkRepository get instance => _instance ??=
      NetworkRepository(datasource: FirebaseNetworkDatasource.instance);

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

  IMapperDto<Relationship, FirebaseDTO> get mapperConnection => _mapperDtoConnection;

  @override
  Future<List<Relationship>> getConnections(String userID) {
    return _datasource.getConnections("requesterUserID", userID, "status", RequestConnectionStatus.accepted.name).then((dtos) {
      return dtos.map((dto) => mapperConnection.toModel(dto)).toList();
    });
  }

  @override
  Future<void> disconnectUser(Relationship connection) {
    return _datasource.disconnectUser(mapperConnection.toDTO(connection));
  }

  @override
  Future<Relationship> createConnection(Relationship connection) {
    return _datasource.createConnection(mapperConnection.toDTO(connection)).then((dto) {
      return mapperConnection.toModel(dto);
    });
  }

  

  @override
  Future<List<Relationship>> getConnectionRequests(String userID) {
    return _datasource.getConnections("addresseeID", userID, "status", RequestConnectionStatus.pending.name).then((dtos) {
      return dtos.map((dto) => mapperConnection.toModel(dto)).toList();
    });
  }

  
  
  @override
  Future<Relationship> updateConnection(Relationship connection) async {
    await _datasource.updateConnection(
      FirebaseDTO(id: connection.id, data: {
        'status': connection.status.name,
        'updatedAt': connection.updatedAt.toIso8601String(),
      })
    );
    return connection;
  }
  
  @override
  Future<List<Relationship>> getConnectionsSent(String userID) {
    return _datasource.getConnections("addresseeID", userID, "status", RequestConnectionStatus.pending.name).then((dtos) {
      return dtos.map((dto) => mapperConnection.toModel(dto)).toList();
    });
  }
}
