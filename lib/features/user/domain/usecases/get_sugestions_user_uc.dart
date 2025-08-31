
import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';
import 'package:demopico/features/profile/presentation/view_objects/suggestion_profile.dart';
import 'package:demopico/features/user/domain/interfaces/i_users_repository.dart';
import 'package:demopico/features/user/infra/repositories/users_repository.dart';

class GetSugestionsUserUc {
  final IUsersRepository _userRepository;
  final INetworkRepository _networkRepository;

  static GetSugestionsUserUc? _instance;
  static GetSugestionsUserUc get instance {
    _instance ??= GetSugestionsUserUc(
      repository: UsersRepository.getInstance,
      networkRepository: NetworkRepository.instance,
    );
    return _instance!;
  }

  GetSugestionsUserUc({required IUsersRepository repository, required INetworkRepository networkRepository})
      : _userRepository = repository,
        _networkRepository = networkRepository;

  Future<List<SuggestionProfile>> execute(String currentUserId) async {
    final allUsers = await _userRepository.findAll();
    final myConnections = await _networkRepository.getConnections(currentUserId);

    final connectedIds = myConnections
        .map((c) => c.requesterUserID == currentUserId ? c.addresseeID : c.requesterUserID)
        .toSet();

    return allUsers
        .where((u) => u.id != currentUserId && !connectedIds.contains(u.id))
        .map((u) => SuggestionProfile.fromUser(u))
        .toList();
  }
}