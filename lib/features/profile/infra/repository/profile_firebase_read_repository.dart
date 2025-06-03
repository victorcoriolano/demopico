import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_database_read_repository.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/user_firebase_repository.dart';


class ProfileFirebaseReadRepository implements IProfileDatabaseReadRepository {
  static ProfileFirebaseReadRepository? _profileFirebaseReadRepository;

  static ProfileFirebaseReadRepository get getInstance {
    _profileFirebaseReadRepository ??= ProfileFirebaseReadRepository(
        userDatabaseRepository: UserFirebaseRepository.getInstance);
    return _profileFirebaseReadRepository!;
  }

  ProfileFirebaseReadRepository(
      {required this.userDatabaseRepository});

  final IUserDatabaseRepository userDatabaseRepository;

  @override
  Future<String> pegarBio(String uid) async {
    UserM? user = await userDatabaseRepository.getUserDetails(uid);
    if (user == null) throw UserNotFoundFailure();
    return user.description!;
  }

  @override
  Future<String> pegarContribuicoes(String uid) async {
    UserM? user = await userDatabaseRepository.getUserDetails(uid);
    if (user == null) throw UserNotFoundFailure();
    return user.picosSalvos!;
  }

  @override
  Future<String> pegarFoto(String uid) async {
    UserM? user = await userDatabaseRepository.getUserDetails(uid);
    if (user == null) throw UserNotFoundFailure();
    return user.pictureUrl!;
  }

  @override
  Future<String> pegarSeguidores(String uid) async {
    UserM? user = await userDatabaseRepository.getUserDetails(uid);
    if (user == null) throw UserNotFoundFailure();
    return user.conexoes!;
  }
}
