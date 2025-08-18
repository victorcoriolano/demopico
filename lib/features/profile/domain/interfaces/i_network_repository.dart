import 'package:demopico/features/user/domain/models/user.dart';

abstract class INetworkRepository {
  Future<List<UserM>> getConnections(String userID);

  Future<void> followUser(String userId, String followerId);
  Future<void> unfollowUser(String userId, String followerId);
}