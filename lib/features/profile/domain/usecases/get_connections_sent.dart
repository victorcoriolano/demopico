import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';
import 'package:demopico/features/user/domain/interfaces/i_users_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/users_repository.dart';
import 'package:flutter/rendering.dart';

class GetConnectionsSentUc {
  static GetConnectionsSentUc? _instance;
  static GetConnectionsSentUc get instance {
    _instance ??= GetConnectionsSentUc(
      networkRepository: NetworkRepository.instance,
      userDataRepository: UsersRepository.getInstance,
    );
    return _instance!;
  }

  GetConnectionsSentUc({
    required INetworkRepository networkRepository, 
    required IUsersRepository userDataRepository})
      : _networkRepository = networkRepository,
        _userDataRepository = userDataRepository;

  final INetworkRepository _networkRepository;
  final IUsersRepository _userDataRepository;


  Future<List<ConnectionReceiver>> execute(String userId) async {
    final relationships = await _networkRepository.getRelationshipSent(userId);
    debugPrint(relationships.toString());
    debugPrint(relationships.map((rel) => rel.addressed).toString());
    debugPrint("Relacionamentos enviados encontrados: ${relationships.length}");
    return relationships.map((rel) => rel.addressed).toList();
  }
}