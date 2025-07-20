import 'package:demopico/features/user/domain/entity/user_credentials.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_auth_repository.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_auth_service.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:demopico/features/user/infra/datasource/remote/user_auth_firebase_service.dart';


class UserAuthFirebaseRepository implements IUserAuthRepository {
  static UserAuthFirebaseRepository? _userAuthFirebaseRepository;

  static UserAuthFirebaseRepository get getInstance {
    _userAuthFirebaseRepository ??= UserAuthFirebaseRepository(userAuthServiceIMP: UserAuthFirebaseService.getInstance, userDatabaseRepositoryIMP: UserDataRepositoryImpl.getInstance);
    return _userAuthFirebaseRepository!;
  }

  UserAuthFirebaseRepository({required this.userDatabaseRepositoryIMP, required this.userAuthServiceIMP});

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
