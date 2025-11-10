
import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';
import 'package:flutter/rendering.dart';

class GetConnectionsRequestsUc {

  static GetConnectionsRequestsUc? _instance;
  static GetConnectionsRequestsUc get instance {
    _instance ??= GetConnectionsRequestsUc(
      networkRepository: NetworkRepository.instance,
    );
    return _instance!;
  }

  final INetworkRepository _networkRepository;

  GetConnectionsRequestsUc({required INetworkRepository networkRepository})
      : _networkRepository = networkRepository;

  Future<List<Relationship>> execute(String uid) async {
    final relationship = await _networkRepository.getRelationshipRequests(uid);
    debugPrint("GET CONNECTONS REQUEST - Relacionamentos requisitado: ${relationship.toString()} - ${relationship.length}");
    return relationship;
  }
}