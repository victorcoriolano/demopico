import 'package:demopico/features/user/domain/models/user.dart';

abstract class IProfileUpdateRepository {
  void updateContributions(UserM user);
  void updateFollowers(UserM user);
  void updateBio(String newBio, UserM user);
  void updatePhoto(String newFoto, UserM user);
}
