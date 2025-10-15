import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';

var dummyConnections = [
  Relationship(
      id: "id",
      createdAt: DateTime.now(),
      requesterUser: UserIdentification(
          id: "userIDnelson", name: "name", profilePictureUrl: "profilePictureUrl"),
      addressed: UserIdentification(
          id: "addressedId",
          name: "addressedName",
          profilePictureUrl: "addressedProfilePictureUrl"),
      status: RequestConnectionStatus.pending,
      updatedAt: DateTime.now()),
  Relationship(
      id: "id2",
      createdAt: DateTime.now(),
      requesterUser: UserIdentification(
          id: "userID1", name: "name", profilePictureUrl: "profilePictureUrl"),
      addressed: UserIdentification(
          id: "addressedId",
          name: "addressedName",
          profilePictureUrl: "addressedProfilePictureUrl"),
      status: RequestConnectionStatus.accepted,
      updatedAt: DateTime.now()),
  Relationship(
      id: "id3",
      createdAt: DateTime.now(),
      requesterUser: UserIdentification(
          id: "userID2", name: "name", profilePictureUrl: "profilePictureUrl"),
      addressed: UserIdentification(
          id: "addressedId2",
          name: "addressedName2",
          profilePictureUrl: "addressedProfilePictureUrl2"),
      status: RequestConnectionStatus.accepted,
      updatedAt: DateTime.now()),

  Relationship(
      id: "id4",
      createdAt: DateTime.now(),
      requesterUser: UserIdentification(
          id: "userID3", name: "name", profilePictureUrl: "profilePictureUrl"),
      addressed: UserIdentification(
          id: "addressedId3",
          name: "addressedName3",
          profilePictureUrl: "addressedProfilePictureUrl3"),
      status: RequestConnectionStatus.accepted,
      updatedAt: DateTime.now()),

  Relationship(
      id: "id5",
      createdAt: DateTime.now(),
      requesterUser: UserIdentification(
          id: "userID4", name: "name", profilePictureUrl: "profilePictureUrl"),
      addressed: UserIdentification(
          id: "addressedId4",
          name: "addressedName4",
          profilePictureUrl: "addressedProfilePictureUrl4"),
      status: RequestConnectionStatus.rejected,
      updatedAt: DateTime.now())
];
