
import 'package:demopico/features/user/domain/models/user.dart';

abstract class IUserDataRepository{
  UserM? get localUser;
  Future<void> addUserDetails(UserM newUser);
  Future<UserM> getUserDetailsByID(String uid);
  Future<String> getEmailByVulgo(String vulgo);
  Future<UserM> updateUserDetails(UserM user);
  Future<bool> validateExist({required String data,required  String field});
}