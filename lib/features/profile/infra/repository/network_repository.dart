
import 'package:demopico/features/profile/domain/interfaces/i_network_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';

class NetworkRepository implements INetworkRepository {

  @override
  Future<List<UserM>> getConnections(String userID) {
    // TODO: implement getConnections
    throw UnimplementedError();
  }

  @override
  Future<void> followUser(String userId, String followerId) {
    // TODO: implement followUser
    throw UnimplementedError();
  }

  @override
  Future<void> unfollowUser(String userId, String followerId) {
    // TODO: implement unfollowUser
    throw UnimplementedError();
  }
}