
import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/domain/models/connection.dart';

class CreateConnectionUsersUc {
  final INetworkRepository _repository;

  CreateConnectionUsersUc({required INetworkRepository repository})
      : _repository = repository;

  Future<Connection> execute(Connection connection) {
    return _repository.createConnection(connection);
  }
}