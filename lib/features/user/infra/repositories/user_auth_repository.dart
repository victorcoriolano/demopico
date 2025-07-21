import 'package:demopico/features/user/domain/entity/user_credentials.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_auth_repository.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_auth_service.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:demopico/features/user/infra/datasource/remote/firebase_auth_service.dart';


class UserAuthRepository implements IUserAuthRepository {
  static UserAuthRepository? _userAuthFirebaseRepository;

  static UserAuthRepository get getInstance {
    _userAuthFirebaseRepository ??= UserAuthRepository(userAuthServiceIMP: FirebaseAuthService.getInstance, userDatabaseRepositoryIMP: UserDataRepositoryImpl.getInstance);
    return _userAuthFirebaseRepository!;
  }

  UserAuthRepository({required this.userDatabaseRepositoryIMP, required this.userAuthServiceIMP});

  final IUserAuthService userAuthServiceIMP;
  final IUserDataRepository userDatabaseRepositoryIMP;


  @override
  Future<UserM> signUp(UserCredentialsSignUp cadastroCredentials) async {
    return await userAuthServiceIMP.signUp(cadastroCredentials);
  }


  @override
  Future<void> logout() async {
    return await userAuthServiceIMP.logout();
  }
  
  @override
  Future<String> login(UserCredentialsSignIn loginCredentials) async {
      return await userAuthServiceIMP.loginByEmail(loginCredentials);
  }
}
