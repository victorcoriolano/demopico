import 'package:demopico/core/common/auth/domain/value_objects/email_vo.dart';
import 'package:demopico/core/common/auth/domain/value_objects/vulgo_vo.dart';
import 'package:demopico/features/user/domain/models/user_model.dart';

abstract class IUserRepository {
  Future<UserM> getById(String id);
  Future<UserM> update(UserM user);
  Future<void> deleteData(String uid);
  Future<UserM> addUserDetails(UserM newUser);
  Future<EmailVO> getEmailByVulgo(VulgoVo vulgo);
  Future<bool> validateExist({required String data,required  String field});
}