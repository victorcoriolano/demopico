import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_database_read_repository.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/user_firebase_repository.dart';

class ProfileReadRepository implements IProfileDatabaseReadRepository {
  static ProfileReadRepository? _profileReadRepository;

  static ProfileReadRepository get getInstance {
    _profileReadRepository ??= ProfileReadRepository(
        userRepositoryIMP: UserFirebaseRepository.getInstance);
    return _profileReadRepository!;
  }

  ProfileReadRepository({required this.userRepositoryIMP});

  final IUserDatabaseRepository userRepositoryIMP;

  @override
  Future<String> pegarBio(UserM userModel) async {
    String? uid = userModel.id;
    if (uid == null) throw UserNotFoundFailure();
    UserM? user = await userRepositoryIMP.getUserDetails(uid);
    if (user == null) throw UserNotFoundFailure();
    return user.description!;
  }

  @override
  Future<int> pegarContribuicoes(UserM userModel) async {
    String? uid = userModel.id;
    if (uid == null) throw UserNotFoundFailure();
    UserM? user = await userRepositoryIMP.getUserDetails(uid);
    if (user == null) throw UserNotFoundFailure();
    return user.picosAdicionados!;
  }

  @override
  Future<String> pegarFoto(UserM userModel) async {
    String? uid = userModel.id;
    if (uid == null) throw UserNotFoundFailure();
    UserM? user = await userRepositoryIMP.getUserDetails(uid);
    if (user == null) throw UserNotFoundFailure();
    return user.pictureUrl!;
  }

  @override
  Future<int> pegarSeguidores(UserM userModel) async {
    String? uid = userModel.id;
    if (uid == null) throw UserNotFoundFailure();
    UserM? user = await userRepositoryIMP.getUserDetails(uid);
    if (user == null) throw UserNotFoundFailure();
    return user.conexoes!;
  }
}
