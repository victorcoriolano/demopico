import 'package:demopico/features/user/presentation/controllers/provider_auth.dart';

class LoginController {
  final ProviderAuth authProvider;

  LoginController({required this.authProvider});

  Future<bool> loginByEmail(
      String email,  String password,  ) async {
    try {
      authProvider.login(email, password);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> loginByVulgo(
    String vulgo, String password) async {
    try {
      final email? = 
      return false;
    } catch (e) {
      rethrow;
    }
  }
}
