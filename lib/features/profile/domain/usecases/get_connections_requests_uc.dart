
import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';
import 'package:demopico/features/user/domain/interfaces/i_users_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/users_repository.dart';

class GetConnectionsRequestsUc {

  static GetConnectionsRequestsUc? _instance;
  static GetConnectionsRequestsUc get instance {
    _instance ??= GetConnectionsRequestsUc(
      networkRepository: NetworkRepository.instance,
      userDataRepository: UsersRepository.getInstance,
    );
    return _instance!;
  }

  final INetworkRepository _networkRepository;
  final IUsersRepository _userDataRepository;

  GetConnectionsRequestsUc({required INetworkRepository networkRepository, required IUsersRepository userDataRepository})
      : _networkRepository = networkRepository,
        _userDataRepository = userDataRepository;

  Future<List<ConnectionRequester>> execute(String uid) async {
    final relationship = await _networkRepository.getRelationshipRequests(uid);
    return relationship.map((rel) => rel.requesterUser).toList();
  }
}