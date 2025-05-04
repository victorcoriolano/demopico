abstract class IUserAuthRepository {
  Future<bool> signUp(String inputName, String inputEmail, String password, bool isColetivo);
  Future<bool> loginByEmail(String email, String password);
  Future<bool> loginByVulgo(String vulgo, String password);
  Future<void> logout();
}
