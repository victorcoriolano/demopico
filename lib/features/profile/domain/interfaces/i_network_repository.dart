import 'package:demopico/features/profile/domain/models/connection.dart';
import 'package:demopico/features/user/domain/models/user.dart';

abstract class INetworkRepository {
  Future<bool> checkConnection(String idConnection);
  Future<Connection> updateConnection(Connection connection);
  Future<List<UserM>> getConnections(String userID);
  Future<List<Connection>> getConnectionRequests(String userID);
  Future<Connection> connectUser(Connection connection);
  Future<void> disconnectUser(Connection connection);
}