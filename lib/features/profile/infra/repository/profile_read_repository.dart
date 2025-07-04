import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_read_repository.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/user_firebase_repository.dart';

class ProfileReadRepository implements IProfileReadRepository {
  static ProfileReadRepository? _profileReadRepository;

  static ProfileReadRepository get getInstance {
    _profileReadRepository ??= ProfileReadRepository(
        userRepositoryIMP: UserFirebaseRepository.getInstance);
    return _profileReadRepository!;
  }

  ProfileReadRepository({required this.userRepositoryIMP});

  final IUserDatabaseRepository userRepositoryIMP;

  @override
  Future<String> getBio(UserM userModel) async {
    String? uid = userModel.id;
    if (uid == null) throw UserNotFoundFailure();
    UserM? user = await userRepositoryIMP.getUserDetails(uid);
    if (user == null) throw UserNotFoundFailure();
    return user.description!;
  }

  @override
  Future<int> getContributions(UserM userModel) async {
    String? uid = userModel.id;
    if (uid == null) throw UserNotFoundFailure();
    UserM? user = await userRepositoryIMP.getUserDetails(uid);
    if (user == null) throw UserNotFoundFailure();
    return user.picosAdicionados!;
  }

  @override
  Future<String> getPhoto(UserM userModel) async {
    String? uid = userModel.id;
    if (uid == null) throw UserNotFoundFailure();
    UserM? user = await userRepositoryIMP.getUserDetails(uid);
    if (user == null) throw UserNotFoundFailure();
    return user.pictureUrl!;
  }

  @override
  Future<int> getFollowers(UserM userModel) async {
    String? uid = userModel.id;
    if (uid == null) throw UserNotFoundFailure();
    UserM? user = await userRepositoryIMP.getUserDetails(uid);
    if (user == null) throw UserNotFoundFailure();
    return user.conexoes!;
  }
}
