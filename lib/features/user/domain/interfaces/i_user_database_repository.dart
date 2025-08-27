
import 'package:demopico/features/user/domain/models/user.dart';

abstract class IUserDataRepository{
  UserM? get localUser;
  Future<void> addUserDetails(UserM newUser);
  Future<UserM> getUserDetailsByID(String uid);
  Future<String> getEmailByVulgo(String vulgo);
  Future<UserM> updateUserDetails(UserM user);
  Stream<List<UserM>> searchUsers(String query);
  Future<List<UserM>> getSuggestionsProfileExcept(String uid);
  Future<List<UserM>> getSuggestionsExceptConnections(Set<String> connectionsExcept);
  Future<bool> validateExist({required String data,required  String field});
}