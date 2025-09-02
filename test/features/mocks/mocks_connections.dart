
import 'package:demopico/features/profile/domain/models/relationship.dart';

var dummyConnections = [
  Relationship(id: "id",createdAt: DateTime.now(), requesterUser: 'userID1', addressed: 'userID4', status: RequestConnectionStatus.pending, updatedAt: DateTime.now()),

  Relationship(id: "id",createdAt: DateTime.now(), requesterUser: 'userID2', addressed: 'userID1', status: RequestConnectionStatus.accepted, updatedAt: DateTime.now()),

  Relationship(id: "id",createdAt: DateTime.now(), requesterUser: 'userID3', addressed: 'userID1', status: RequestConnectionStatus.accepted, updatedAt: DateTime.now())
  ,Relationship(id: "id",createdAt: DateTime.now(), requesterUser: 'userID4', addressed: 'userID3', status: RequestConnectionStatus.rejected, updatedAt: DateTime.now())

];