import 'package:demopico/features/profile/domain/models/relationship.dart';

abstract class INetworkRepository {
  Future<Relationship> updateConnection(Relationship connection);
  Future<List<Relationship>> getConnections(String userID);
  Future<List<Relationship>> getConnectionRequests(String userID);
  Future<List<Relationship>> getConnectionsSent(String userID);
  Future<Relationship> createConnection(Relationship connection);
  Future<void> disconnectUser(Relationship connection);
}