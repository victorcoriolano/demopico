import 'package:demopico/features/user/domain/entity/user_credentials.dart';
import 'package:demopico/features/user/domain/enums/sign_methods.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_auth_repository.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_auth_service.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/user_firebase_repository.dart';
import 'package:demopico/features/user/infra/datasource/remote/user_auth_firebase_service.dart';


class UserAuthFirebaseRepository implements IUserAuthRepository {
  static UserAuthFirebaseRepository? _userAuthFirebaseRepository;

  static UserAuthFirebaseRepository get getInstance {
    _userAuthFirebaseRepository ??= UserAuthFirebaseRepository(userAuthServiceIMP: UserAuthFirebaseService.getInstance, userDatabaseRepositoryIMP: UserRepositoryImpl.getInstance);
    return _userAuthFirebaseRepository!;
  }

  UserAuthFirebaseRepository({required this.userDatabaseRepositoryIMP, required this.userAuthServiceIMP});

  final IUserAuthService userAuthServiceIMP;
  final IUserDatabaseRepository userDatabaseRepositoryIMP;
  @override
  Future<void> loginByEmail(UserCredentialsSignIn loginCredentials) async {
  
      await userAuthServiceIMP.loginByEmail(loginCredentials);
  
     
  }

  @override
  Future<void> loginByVulgo(UserCredentialsSignInVulgo loginCredentials) async {
      String vulgo = loginCredentials.vulgo;
      String email = await userDatabaseRepositoryIMP.getEmailByVulgo(vulgo);

      final credentials = UserCredentialsSignIn(
        email: email,
        signMethod: SignMethods.email,
        password: loginCredentials.password,
      );
      
      return await userAuthServiceIMP.loginByEmail(credentials);
  }

  @override
  Future<UserM> signUp(UserCredentialsSignUp cadastroCredentials) async {
    return await userAuthServiceIMP.signUp(cadastroCredentials);
  }


  @override
  Future<void> logout() async {
    return await userAuthServiceIMP.logout();
  }
}
