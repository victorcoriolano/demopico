
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';
import 'package:demopico/features/profile/presentation/object_for_only_view/suggestion_profile.dart';
import 'package:demopico/features/user/domain/interfaces/i_users_repository.dart';
import 'package:demopico/features/user/infra/repositories/users_repository.dart';
import 'package:flutter/rendering.dart';

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

  Future<List<SuggestionProfile>> execute(UserEntity user) async {
    final currentUserId = user.id;
    final allUsers = await _userRepository.findAll();
    final myConnectionsSent = await _networkRepository.getRelationshipSent(currentUserId);
    final myConnectionsAccepted = await _networkRepository.getRelationshipAccepted(currentUserId);
    final myConnectionsRequests = await _networkRepository.getRelationshipRequests(currentUserId);

    debugPrint("Relacionamentos enviados encontrados: ${myConnectionsSent.length}");
    debugPrint("Relacionamentos aceitos encontrados: ${myConnectionsAccepted.length}");
    debugPrint("Relacionamentos solicitados encontrados: ${myConnectionsRequests.length}");

    final exceptProfiles = [
      ...myConnectionsSent.map((c) => c.addressed),
      ...myConnectionsAccepted.map((c) => c.requesterUser),
      ...myConnectionsAccepted.map((c) => c.addressed),
      ...myConnectionsRequests. map((c) => c.requesterUser),
    ];

    return allUsers
        .where((u) => u.id != currentUserId && !exceptProfiles.map((e) => e.id).contains(u.id))
        .map((u) => SuggestionProfile.fromUser(u))
        .toList(); 
  }
}