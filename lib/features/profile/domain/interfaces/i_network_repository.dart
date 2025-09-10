import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/presentation/view_objects/relationship_vo.dart';

abstract class INetworkRepository {
  // TODO : arrumar os tipagem para VO
  Future<Relationship> updateRelationship(RelationshipVo connection);
  Future<List<Relationship>> getRelationshipAccepted(String userID);
  Future<List<Relationship>> getRelationshipRequests(String userID);
  Future<List<Relationship>> getRelationshipSent(String userID);
  Future<Relationship> createRelationship(Relationship connection);
  Future<void> deleteRelationship(Relationship connection);
}