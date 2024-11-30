import 'package:demopico/core/common/inject_dependencies.dart';
import 'package:demopico/features/user/data/services/auth_service_v2.dart';

class AuthController {
  final _authService = AuthService();

  Future<bool> login(String email, String password) async {
    return await _authService.login(email, password);
  }

  Future<bool> logout() async {
    try {
      await _authService.logout();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signUp(String inputName, String inputEmail, String inputPassword,
      bool isColetivo) async {
    return await _authService.signUp(
        inputName, inputEmail, inputPassword, isColetivo);
  }
}
