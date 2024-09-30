//register controller
import 'package:demopico/core/common/inject_dependencies.dart';
import 'package:demopico/features/user/presentation/controllers/provider_auth.dart';

class RegisterController {
  Future<bool> registrarUserNoFirebase(String email, String senha, String vulgo, bool isColetivo) async {
      final registradoOrFailure = await serviceLocator<ProviderAuth>().registerOnFirebase(email, senha);
      return registradoOrFailure.isRight();
  }
  Future<bool> registrarUserNoFireStore(String email, String vulgo,) async {
      final deuBom = await serviceLocator<ProviderAuth>().registerEmailAndVulgo(email, vulgo);
      return deuBom;
  }
}