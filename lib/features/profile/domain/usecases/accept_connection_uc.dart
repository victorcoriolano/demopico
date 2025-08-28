
import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/profile/domain/models/connection.dart';
import 'package:demopico/features/profile/infra/repository/network_repository.dart';

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

  Future<Connection> execute(Connection connection) async {
    return await _networkRepository.updateConnection(connection);
  }
}