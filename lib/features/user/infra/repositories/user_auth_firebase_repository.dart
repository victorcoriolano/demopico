import 'package:demopico/features/user/domain/entity/user_credentials.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_auth_repository.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_auth_service.dart';
import 'package:demopico/features/user/infra/services/user_auth_firebase_service.dart';


class UserAuthFirebaseRepository implements IUserAuthRepository {
  static UserAuthFirebaseRepository? _userAuthFirebaseRepository;

  static UserAuthFirebaseRepository get getInstance {
    _userAuthFirebaseRepository ??= UserAuthFirebaseRepository(userAuthServiceIMP: UserAuthFirebaseService.getInstace);
    return _userAuthFirebaseRepository!;
  }

  UserAuthFirebaseRepository({required this.userAuthServiceIMP});

  final IUserAuthService userAuthServiceIMP;
  @override
  Future<bool> loginByEmail(UserCredentialsSignIn loginCredentials) async {
      String email = loginCredentials.email;
      String senha = loginCredentials.password;
    return await userAuthServiceIMP.loginByEmail(email, senha);
  }

  @override
  Future<bool> loginByVulgo(UserCredentialsSignInVulgo loginCredentials) async {
      String vulgo = loginCredentials.vulgo;
      String senha = loginCredentials.password;
      

      return await userAuthServiceIMP.loginByEmail(email, senha);
  }

  @override
  Future<bool> signUp(UserCredentialsSignUp cadastroCredentials) async {
      String email = cadastroCredentials.credentials.email;
      String senha = cadastroCredentials.credentials.password;
      bool coletivo = cadastroCredentials.isColetivo;
      String nome = cadastroCredentials.nome;

    return await userAuthServiceIMP.signUp(nome, email, senha, coletivo);
  }
  @override
  Future<void> logout() async {
    return await userAuthServiceIMP.logout();
  }
}
