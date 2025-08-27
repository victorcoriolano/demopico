
import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/domain/models/connection.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';

class CreateConnectionUsersUc {
  final INetworkRepository _repository;

  static CreateConnectionUsersUc? _instance;

  static CreateConnectionUsersUc get instance {
    _instance ??= CreateConnectionUsersUc(
      repository: NetworkRepository.instance,
    );
    return _instance!;
  }

  CreateConnectionUsersUc({required INetworkRepository repository})
      : _repository = repository;

  Future<Connection> execute(Connection connection) {
    return _repository.createConnection(connection);
  }
}