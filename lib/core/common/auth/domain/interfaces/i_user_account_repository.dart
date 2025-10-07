abstract class IUserAccountRepository {
  bool get isVerified;
  Future<void> sendEmailVerification();
  Future<bool> changePassWord();    
  Future<void> deleteAccount();
} 