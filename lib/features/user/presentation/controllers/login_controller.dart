import 'package:demopico/features/user/data/services/auth_service.dart';
import 'package:demopico/features/user/data/services/firebase_service.dart';

class LoginController {
  final AuthService authService;
  final FirebaseService firebaseService;
  String? id;
  String? email;
  LoginController({required this.authService, required this.firebaseService});

  Future<bool> loginByEmail(
      {required String email, required String password}) async {
    try {
      authService.login(email, password);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> loginByVulgo(
      {required String vulgo, required String password}) async {
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
