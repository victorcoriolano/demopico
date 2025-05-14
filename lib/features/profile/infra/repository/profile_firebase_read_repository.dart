import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_database_read_repository.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_auth_service.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/user_firebase_repository.dart';
import 'package:demopico/features/user/infra/services/user_auth_firebase_service.dart';

class ProfileFirebaseReadRepository implements IProfileDatabaseReadRepository {
  static ProfileFirebaseReadRepository? _profileFirebaseReadRepository;

  static ProfileFirebaseReadRepository get getInstance {
    _profileFirebaseReadRepository ??= ProfileFirebaseReadRepository(
        userAuthServiceIMP: UserAuthFirebaseService.getInstance,
        userDatabaseRepository: UserFirebaseRepository.getInstance);
    return _profileFirebaseReadRepository!;
  }

  ProfileFirebaseReadRepository(
      {required this.userAuthServiceIMP, required this.userDatabaseRepository});

  final IUserAuthService userAuthServiceIMP;
  final IUserDatabaseRepository userDatabaseRepository;

  @override
  Future<String> pegarBio() async {
    String uid = userAuthServiceIMP.currentUser();
    UserM? user = await userDatabaseRepository.getUserDetails(uid);
    if (user == null) throw UserNotFoundFailure();
    return user.description!;
  }

  @override
  Future<String> pegarContribuicoes() async {
    String uid = userAuthServiceIMP.currentUser();
    UserM? user = await userDatabaseRepository.getUserDetails(uid);
    if (user == null) throw UserNotFoundFailure();
    return user.picosSalvos!;
  }

  @override
  Future<String> pegarFoto() async {
    String uid = userAuthServiceIMP.currentUser();
    UserM? user = await userDatabaseRepository.getUserDetails(uid);
    if (user == null) throw UserNotFoundFailure();
    return user.pictureUrl!;
  }

  @override
  Future<String> pegarSeguidores() async {
    String uid = userAuthServiceIMP.currentUser();
    UserM? user = await userDatabaseRepository.getUserDetails(uid);
    if (user == null) throw UserNotFoundFailure();
    return user.conexoes!;
  }
}
