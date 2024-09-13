import 'package:demopico/features/login/data/services/auth_service.dart';
import 'package:demopico/features/login/data/services/firebase_service.dart';

class LoginController {
  final AuthService authService;
  final FirebaseService firebaseService;
  String? id;
  String? email;
  LoginController({required this.authService, required this.firebaseService});

  Future<bool> loginByEmail(String email, String password) async {
    try {
      authService.login(email, password);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> loginByVulgo(String vulgo, String password) async {
    try {
      id = await firebaseService.getIDByVulgo(vulgo);
      if (id != null) {
        email = await firebaseService.getEmailByID(id!);
        try {
          authService.login(email!, password);
          return true;
        } catch (e) {
          rethrow;
        }
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }
}
