import 'package:demopico/features/user/domain/models/user.dart';

abstract class IProfileUpdateRepository {
  Future<void> updateContributions(UserM user);
  Future<void> updateFollowers(UserM user);
  Future<void> updateBio(String newBio, UserM user);
  Future<void> updatePhoto(String newFoto, UserM user);
}
