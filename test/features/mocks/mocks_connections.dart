
import 'package:demopico/features/profile/domain/models/connection.dart';

var dummyConnections = [
  Connection(id: "id",createdAt: DateTime.now(), userID: 'userID1', connectedUserID: 'userID4', status: RequestConnectionStatus.pending, updatedAt: DateTime.now()),

  Connection(id: "id",createdAt: DateTime.now(), userID: 'userID2', connectedUserID: 'userID1', status: RequestConnectionStatus.accepted, updatedAt: DateTime.now()),

  Connection(id: "id",createdAt: DateTime.now(), userID: 'userID3', connectedUserID: 'userID1', status: RequestConnectionStatus.accepted, updatedAt: DateTime.now())
  ,Connection(id: "id",createdAt: DateTime.now(), userID: 'userID4', connectedUserID: 'userID3', status: RequestConnectionStatus.rejected, updatedAt: DateTime.now())

];