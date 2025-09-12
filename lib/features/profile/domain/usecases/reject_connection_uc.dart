
import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';
import 'package:demopico/features/profile/presentation/view_objects/relationship_vo.dart';

class RejectConnectionUc {
  static RejectConnectionUc? _instance;
  static RejectConnectionUc get instance {
    _instance ??= RejectConnectionUc(
      networkRepository: NetworkRepository.instance,
    );
    return _instance!;
  }

  final INetworkRepository _networkRepository;

  RejectConnectionUc({required INetworkRepository networkRepository})
      : _networkRepository = networkRepository;

  Future<void> execute(RelationshipVo connection) async {
     _networkRepository.deleteRelationship(connection);
  }
}