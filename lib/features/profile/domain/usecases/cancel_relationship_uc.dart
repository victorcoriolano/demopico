
import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';
import 'package:demopico/features/profile/presentation/view_objects/relationship_vo.dart';

class CancelRelationshipUc {
  static CancelRelationshipUc? _instance;
  static CancelRelationshipUc get instance {
    _instance ??= CancelRelationshipUc(
      networkRepository: NetworkRepository.instance
    );
    return _instance!;
  }

  final INetworkRepository _networkRepository;

  CancelRelationshipUc({required INetworkRepository networkRepository})
      : _networkRepository = networkRepository;

  Future<void> execute(RelationshipVo relationship) async {
    await _networkRepository.deleteRelationship(relationship);
  }

}