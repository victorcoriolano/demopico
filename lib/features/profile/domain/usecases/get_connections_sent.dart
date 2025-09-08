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


  Future<List<ConnectionReceiver>> execute(String userId) async {
    final relationships = await _networkRepository.getRelationshipSent(userId);
    debugPrint(relationships.toString());
    debugPrint(relationships.map((rel) => rel.addressed).toString());
    debugPrint("Relacionamentos enviados encontrados: ${relationships.length}");
    return relationships.map((rel) => rel.addressed).toList();
  }
}