import 'package:demopico/features/user/domain/models/user.dart';

abstract class IDatabaseService{
  Future<void> addUserDetails(UserM newUser);
  Future<UserM?> getUserDetails(String uid);
  Future<String?> getUserIDByVulgo(String vulgo);
  Future<String?> getEmailByUserID(String uid);
}