import 'package:demopico/features/user/domain/models/user.dart';

abstract class IUserDatabaseService{
  Future<void> addUserDetails(UserM newUser, String uid);
  Future<UserM?> getUserDetails(String uid);
  Future<String?> getUserIDByVulgo(String vulgo);
  Future<String?> getEmailByUserID(String uid);
  Future<String?> getEmailByVulgo(String vulgo);
  
}