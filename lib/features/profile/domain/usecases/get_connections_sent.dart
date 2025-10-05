import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';
import 'package:flutter/rendering.dart';

class GetConnectionsSentUc {
  static GetConnectionsSentUc? _instance;
  static GetConnectionsSentUc get instance {
    _instance ??= GetConnectionsSentUc(
      networkRepository: NetworkRepository.instance,
    );
    return _instance!;
  }

  GetConnectionsSentUc({
    required INetworkRepository networkRepository,})
      : _networkRepository = networkRepository;

  final INetworkRepository _networkRepository;


  Future<List<Relationship>> execute(String userId) async {
    final relationships = await _networkRepository.getRelationshipSent(userId);
    debugPrint("GETCONNECTIONSSENT - Relacionamentos enviados: ${relationships.toString()} - ${relationships.length}");
    return relationships;
  }
}