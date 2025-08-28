
import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/domain/models/connection.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';

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

  Future<void> execute(Connection connection) async {
     _networkRepository.disconnectUser(connection);
  }
}