import 'package:demopico/features/user/domain/models/user.dart';

abstract class IProfileReadRepository {
  Future<int> getContributions(UserM userModel);
  Future<int> getFollowers(UserM userModel);
  Future<String> getBio(UserM userModel);
  Future<String> getPhoto(UserM userModel);
}
