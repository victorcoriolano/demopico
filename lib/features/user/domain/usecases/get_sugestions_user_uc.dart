
import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';

class GetSugestionsUser {
  final IUserDataRepository _repository;
  final INetworkRepository _networkRepository;

  GetSugestionsUser({required IUserDataRepository repository, required INetworkRepository networkRepository})
      : _repository = repository,
        _networkRepository = networkRepository;

  Future<List<UserM>> call(String idUser) async {
    final connectionsUser = await _networkRepository.getConnections(idUser);
    if (connectionsUser.isEmpty) {
      //não tem conexões então a lista de sugestões será a lista de usuários
      return _repository.getUsers();
    }
    final ids = connectionsUser.map((e) => e.id).toList();
    return await _repository.getSuggestions(ids);
  }
}