
import 'package:demopico/features/user/data/services/auth_service.dart';

class AuthController {
  final _authService = AuthService();

  Future<bool> login(String email, String password) async {
    try{
      return await _authService.loginIn(email, password);
    }catch(e){
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
    await _authService
        .signUp(inputName, inputEmail, inputPassword, isColetivo)
        .then((value) => print(value))
        .whenComplete(() => print('finalizado'));
    bool result = await _authService.loginIn(inputEmail, inputPassword);
    return result;
  }
}
