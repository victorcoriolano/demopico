import 'package:demopico/features/user/domain/entity/user_credentials.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_auth_repository.dart';
import 'package:demopico/features/user/infra/repositories/user_auth_firebase_repository.dart';


class CriarContaUc {
  static CriarContaUc? _criarContaUc;
  static CriarContaUc get getInstance {
    _criarContaUc ??= CriarContaUc(
        userAuthRepositoryIMP: UserAuthFirebaseRepository.getInstance);
    return _criarContaUc!;
  }

  final IUserAuthRepository userAuthRepositoryIMP;


  CriarContaUc(
      {required this.userAuthRepositoryIMP});

  Future<bool> criar(UserCredentialsSignUp credentials) async {
    try {
      if (credentials.credentials.password.length <= 7) throw Exception("Senha muito curta");
      if (!credentials.credentials.email.contains('@'))throw Exception("Email inválido");
      if(credentials.nome.length <= 2) throw Exception("Nome muito curto");

      return await userAuthRepositoryIMP.signUp(credentials);
    } catch (e) {
      return false;
    }
  }
}
