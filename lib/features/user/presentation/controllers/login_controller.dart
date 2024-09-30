import 'package:dartz/dartz.dart';
import 'package:demopico/core/common/inject_dependencies.dart';
import 'package:demopico/features/user/domain/interfaces/firebase_interface.dart';
import 'package:demopico/features/user/presentation/controllers/provider_auth.dart';

class LoginController {
  final ProviderAuth authProvider;

  LoginController({required this.authProvider});


  Future<bool> loginByEmail(
    String email,
    String password,
  ) async {
    try {
      final result = await authProvider.login(email, password);
      if (result is Right) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> loginByVulgo(String vulgo, String senha) async {
    FirebaseInterface firebaseInterface = serviceLocator<FirebaseInterface>();
    try {
      String? id = await firebaseInterface.getIDByVulgo(vulgo);
      if (id != null) {
        final String? emailForVulgo = await firebaseInterface.getEmailByID(id);
        if (emailForVulgo != null) {
          final result =  await authProvider.login(emailForVulgo, senha);
          result is Right ? true : false;
        } else {
          return false;
        }
      } else {
        return false;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }
}
