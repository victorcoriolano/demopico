import 'package:demopico/features/user/infra/services/auth_service.dart';

class AuthController {
  final _authService = AuthService();

  Future<bool> login(String email, String password) async {
    try {
      return await _authService.login(email, password);
    } catch (e) {
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      await _authService.logout();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signUp(
      {required String inputName,
      required String inputEmail,
      required String inputPassword,
      required bool isColetivo}) async {
    bool result = false;
    await _authService
        .signUp(inputName, inputEmail, inputPassword, isColetivo)
        .then((value) => value ? null : result = false);
    result = await _authService.login(inputEmail, inputPassword);
    return result;
  }
}
