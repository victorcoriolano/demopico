
import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';
import 'package:demopico/features/user/domain/models/user_model.dart';

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

  Future<Relationship> execute(Relationship connection, UserM user) async {
    final output = await _repository.createRelationship(connection);
    return output;
  }
}