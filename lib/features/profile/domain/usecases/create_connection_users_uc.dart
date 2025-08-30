
import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/domain/models/connection.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';

class CreateConnectionUsersUc {
  final INetworkRepository _repository;
  final IUserDataRepository _userDataRepository;

  static CreateConnectionUsersUc? _instance;

  static CreateConnectionUsersUc get instance {
    _instance ??= CreateConnectionUsersUc(
      repository: NetworkRepository.instance,
      userDataRepository: UserDataRepositoryImpl.getInstance,
    );
    return _instance!;
  }

  CreateConnectionUsersUc({required INetworkRepository repository, required IUserDataRepository userDataRepository})
      : _repository = repository,
        _userDataRepository = userDataRepository;

  Future<Connection> execute(Connection connection) {
    final output = _repository.createConnection(connection);
    return output;
  }
}