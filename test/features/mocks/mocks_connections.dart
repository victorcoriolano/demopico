import 'package:demopico/features/profile/domain/models/relationship.dart';

var dummyConnections = [
  Relationship(
      id: "id",
      createdAt: DateTime.now(),
      requesterUser: ConnectionRequester(
          id: "userID", name: "name", profilePictureUrl: "profilePictureUrl"),
      addressed: ConnectionReceiver(
          id: "addressedId",
          name: "addressedName",
          profilePictureUrl: "addressedProfilePictureUrl"),
      status: RequestConnectionStatus.pending,
      updatedAt: DateTime.now()),
  Relationship(
      id: "id",
      createdAt: DateTime.now(),
      requesterUser: ConnectionRequester(
          id: "userID1", name: "name", profilePictureUrl: "profilePictureUrl"),
      addressed: ConnectionReceiver(
          id: "addressedId",
          name: "addressedName",
          profilePictureUrl: "addressedProfilePictureUrl"),
      status: RequestConnectionStatus.accepted,
      updatedAt: DateTime.now()),
  Relationship(
      id: "id",
      createdAt: DateTime.now(),
      requesterUser: ConnectionRequester(
          id: "userID2", name: "name", profilePictureUrl: "profilePictureUrl"),
      addressed: ConnectionReceiver(
          id: "addressedId2",
          name: "addressedName2",
          profilePictureUrl: "addressedProfilePictureUrl2"),
      status: RequestConnectionStatus.accepted,
      updatedAt: DateTime.now()),

  Relationship(
      id: "id",
      createdAt: DateTime.now(),
      requesterUser: ConnectionRequester(
          id: "userID3", name: "name", profilePictureUrl: "profilePictureUrl"),
      addressed: ConnectionReceiver(
          id: "addressedId3",
          name: "addressedName3",
          profilePictureUrl: "addressedProfilePictureUrl3"),
      status: RequestConnectionStatus.accepted,
      updatedAt: DateTime.now()),

  Relationship(
      id: "id",
      createdAt: DateTime.now(),
      requesterUser: ConnectionRequester(
          id: "userID4", name: "name", profilePictureUrl: "profilePictureUrl"),
      addressed: ConnectionReceiver(
          id: "addressedId4",
          name: "addressedName4",
          profilePictureUrl: "addressedProfilePictureUrl4"),
      status: RequestConnectionStatus.rejected,
      updatedAt: DateTime.now())
];
