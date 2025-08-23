
import 'package:demopico/features/user/domain/models/user.dart';

abstract class IUserDataRepository{
  UserM? get localUser;
  Future<void> addUserDetails(UserM newUser);
  Future<UserM> getUserDetailsByID(String uid);
  Future<String> getEmailByVulgo(String vulgo);
  Future<UserM> updateUserDetails(UserM user);
  Stream<List<UserM>> searchUsers(String query);
  Future<List<UserM>> getSuggestions(List<String> arguments);
  Future<bool> validateExist({required String data,required  String field});
}