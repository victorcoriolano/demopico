import 'package:demopico/core/common/files_manager/enums/collections.dart';
import 'package:demopico/features/external/datasources/firebase/crud_firebase.dart';
import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto.dart';
import 'package:demopico/features/profile/domain/interfaces/i_network_datasource.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';

class FirebaseNetworkDatasource implements INetworkDatasource<FirebaseDTO> {
  final CrudFirebase _crudFirebaseBoilerplate;

  FirebaseNetworkDatasource({required CrudFirebase crudFirebase})
      : _crudFirebaseBoilerplate = crudFirebase;

  static FirebaseNetworkDatasource? _instance;

  static FirebaseNetworkDatasource get instance {
    _instance ??= FirebaseNetworkDatasource(
      crudFirebase: CrudFirebase.getInstance
        ..collection = Collections.connections,
    );
    return _instance!;
  }

  @override
  Future<FirebaseDTO> createConnection(FirebaseDTO dto) async {
    return await _crudFirebaseBoilerplate.create(dto);
  }

  @override
  Future<List<FirebaseDTO>> getConnections(String field, String value) async {
    return await _crudFirebaseBoilerplate.readAllWithFilter(field, value);
  }

  @override
  Future<void> disconnectUser(FirebaseDTO dto) async {
    await _crudFirebaseBoilerplate.delete(dto.id);
  }

  @override
  Future<List<FirebaseDTO>> fetchRequestConnections (String userID) {
    return _crudFirebaseBoilerplate.readWithTwoFilters(
        field1: 'userID',
        value1: userID,
        field2: 'status',
        value2: RequestConnectionStatus.pending.name);
  }
  
  @override
  Future<FirebaseDTO> checkConnection(String idConnection) {
    return _crudFirebaseBoilerplate.read(idConnection);
  }
  
  @override
  Future<FirebaseDTO> updateConnection(FirebaseDTO dto) async {
    return await _crudFirebaseBoilerplate.update(dto);
  }
}
