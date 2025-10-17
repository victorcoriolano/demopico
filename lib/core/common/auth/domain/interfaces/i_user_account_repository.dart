import 'package:demopico/core/common/auth/domain/value_objects/password_vo.dart';

abstract class IUserAccountRepository {
  bool get isVerified;
  Future<void> sendEmailVerification();
  Future<bool> resetPassword(String email); 
  Future<void> updatePassword(PasswordVo password);   
  Future<void> deleteAccount();
} 