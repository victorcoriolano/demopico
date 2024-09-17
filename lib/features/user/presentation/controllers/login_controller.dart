import 'package:demopico/core/errors/failure_server.dart';
import 'package:demopico/features/user/presentation/controllers/provider_auth.dart';

class LoginController {
  final ProviderAuth authProvider;

  LoginController({required this.authProvider});

  Future<bool> loginByEmail(
    String email,
    String password,
  ) async {
    try {
      authProvider.login(email, password);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> loginByVulgo(String vulgo, String senha) async {
    try {
      final String? emailForVulgo = repository.getEmail();
      if (emailForVulgo != null) {
        authProvider.login(emailForVulgo, senha);
      } else {
        throw UserNotFoundFailure();
      }
    } catch (e) {
      rethrow;
    }
  }
}
