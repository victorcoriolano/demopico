import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';
import 'package:demopico/features/profile/presentation/view_objects/relationship_vo.dart';
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
  RelationshipVo? relationshipVo;

  Future<List<RelationshipVo>> execute(String userId) async {
    final relationships = await _networkRepository.getRelationshipSent(userId);

    final relationshipVo = relationships.map((rel) {
      return RelationshipVo(
        requester: rel.requesterUser, 
        idRelationship: rel.id,
        addressed: rel.addressed,
      );
    }).toList();
    debugPrint(relationships.toString());
    debugPrint(relationships.map((rel) => rel.addressed).toString());
    debugPrint("Relacionamentos enviados encontrados: ${relationships.length}");
    
    return relationshipVo;  
    }
}