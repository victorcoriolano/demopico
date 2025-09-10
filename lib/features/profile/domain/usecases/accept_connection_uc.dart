
import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';
import 'package:demopico/features/profile/presentation/view_objects/relationship_vo.dart';

class AcceptConnectionUc {
  static AcceptConnectionUc? _instance;
  static AcceptConnectionUc get instance {
    _instance ??= AcceptConnectionUc(
      networkRepository: NetworkRepository.instance,
    );
    return _instance!;
  }

  final INetworkRepository _networkRepository;

  AcceptConnectionUc({required INetworkRepository networkRepository})
      : _networkRepository = networkRepository;

  Future<Relationship> execute(RelationshipVo connection) async {
    connection.status = RequestConnectionStatus.accepted;
    return await _networkRepository.updateRelationship(connection);
  }
}