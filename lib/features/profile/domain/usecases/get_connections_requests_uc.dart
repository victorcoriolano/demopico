import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';
import 'package:demopico/features/profile/presentation/view_objects/relationship_vo.dart';

class GetConnectionsRequestsUc {

  static GetConnectionsRequestsUc? _instance;
  static GetConnectionsRequestsUc get instance {
    _instance ??= GetConnectionsRequestsUc(
      networkRepository: NetworkRepository.instance,
    );
    return _instance!;
  }

  final INetworkRepository _networkRepository;
  RelationshipVo? relationshipVo;

  GetConnectionsRequestsUc({required INetworkRepository networkRepository})
      : _networkRepository = networkRepository;

  Future<List<RelationshipVo>> execute(String uid) async {

    final relationship = await _networkRepository.getRelationshipRequests(uid);



    
    final relationshipVo = relationship.map((rel) {
      return RelationshipVo(
        requester: rel.requesterUser, 
        idRelationship: rel.id,
        addressed: rel.addressed, 
      );
    }).toList();

    return relationshipVo;
  }
}