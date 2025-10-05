
import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';

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

  Future<void> execute(Relationship relationship) async {
    await _networkRepository.deleteRelationship(relationship.id);
  }

}