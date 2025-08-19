import 'package:demopico/features/profile/domain/models/connection.dart';
import 'package:demopico/features/user/domain/models/user.dart';

abstract class INetworkRepository {
  Future<List<UserM>> getConnections(String userID);
  Future<List<Connection>> getConnectionRequests(String userID);
  Future<void> connectUser(Connection connection);
  Future<void> disconnectUser(Connection connection);
}