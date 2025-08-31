
import 'package:demopico/features/profile/domain/models/relationship.dart';

var dummyConnections = [
  Relationship(id: "id",createdAt: DateTime.now(), requesterUserID: 'userID1', addresseeID: 'userID4', status: RequestConnectionStatus.pending, updatedAt: DateTime.now()),

  Relationship(id: "id",createdAt: DateTime.now(), requesterUserID: 'userID2', addresseeID: 'userID1', status: RequestConnectionStatus.accepted, updatedAt: DateTime.now()),

  Relationship(id: "id",createdAt: DateTime.now(), requesterUserID: 'userID3', addresseeID: 'userID1', status: RequestConnectionStatus.accepted, updatedAt: DateTime.now())
  ,Relationship(id: "id",createdAt: DateTime.now(), requesterUserID: 'userID4', addresseeID: 'userID3', status: RequestConnectionStatus.rejected, updatedAt: DateTime.now())

];