
abstract class IUserAuthService {
  Future<bool> signUp(String inputName, String inputEmail, String password, bool isColetivo);
  Future<bool> loginByEmail(String email, String password);
  Future<void> logout();
  String currentUser();
}