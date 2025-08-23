import 'package:demopico/core/common/files_manager/mappers/i_mapper_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/profile/domain/interfaces/i_network_datasource.dart';
import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/domain/models/connection.dart';
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

  final IMapperDto<Connection, FirebaseDTO> _mapperDtoConnection = FirebaseDtoMapper<Connection>(
    fromJson: (Map<String, dynamic> map, String id) => Connection.fromJson(map, id), 
    toMap: (Connection model) => model.toJson(), 
    getId: (Connection model) => model.id
  );

  IMapperDto<UserM, FirebaseDTO> get mapperUser => _mapperDtoUser;

  IMapperDto<Connection, FirebaseDTO> get mapperConnection => _mapperDtoConnection;

  @override
  Future<List<UserM>> getConnections(String userID) {
    return _datasource.getConnections(userID).then((dtos) {
      return dtos.map((dto) => mapperUser.toModel(dto)).toList();
    });
  }

  @override
  Future<void> disconnectUser(Connection connection) {
    return _datasource.disconnectUser(mapperConnection.toDTO(connection));
  }

  @override
  Future<Connection> connectUser(Connection connection) {
    return _datasource.connectUser(mapperConnection.toDTO(connection)).then((dto) {
      return mapperConnection.toModel(dto);
    });
  }

  

  @override
  Future<List<Connection>> getConnectionRequests(String userID) {
    return _datasource.fetchRequestConnections(userID).then((dtos) {
      return dtos.map((dto) => mapperConnection.toModel(dto)).toList();
    });
  }
  
  @override
  Future<Connection> updateConnection(Connection connection) async {
    final output = await _datasource.updateConnection(mapperConnection.toDTO(connection));
    return mapperConnection.toModel(output);
  }
  
  @override
  Future<Connection> checkConnection(String idConnection) async {
    return _mapperDtoConnection.toModel(await _datasource.checkConnection(idConnection));
  }
}
