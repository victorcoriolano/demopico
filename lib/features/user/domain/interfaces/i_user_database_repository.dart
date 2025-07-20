
import 'package:demopico/features/user/domain/models/user.dart';

abstract class IUserDataRepository{
  Future<void> addUserDetails(UserM newUser);
  Future<UserM> getUserDetailsByID(String uid);
  Future<String> getEmailByVulgo(String vulgo);
  Future<UserM> updateUserDetails(UserM user);
  Future<bool> validateDataUserAfter({required String data,required  String field});
  Future<bool> validateDataUserBefore({required String data, required  String field});
}