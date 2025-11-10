import 'package:demopico/features/profile/domain/models/relationship.dart';

abstract class INetworkRepository {
  Future<Relationship> updateRelationship(Relationship connection);
  Future<List<Relationship>> getRelationshipAccepted(String userID);
  Future<List<Relationship>> getRelationshipRequests(String userID);
  Future<List<Relationship>> getRelationshipSent(String userID);
  Future<Relationship> createRelationship(Relationship connection);
  Future<void> deleteRelationship(String id);
}