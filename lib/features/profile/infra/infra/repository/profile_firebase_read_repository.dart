import 'package:demopico/features/profile/infra/domain/interfaces/profile_database_read_repository.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_service.dart';
import 'package:demopico/features/user/infra/services/user_firebase_service.dart';

class ProfileFirebaseReadRepository implements IProfileDatabaseReadRepository{

  static ProfileFirebaseReadRepository? _profileFirebaseReadRepository;

  static ProfileFirebaseReadRepository get getInstance{
    _profileFirebaseReadRepository ??= ProfileFirebaseReadRepository(userDatabaseServiceIMP: UserFirebaseService.getInstance);
    return _profileFirebaseReadRepository!;
  }

  ProfileFirebaseReadRepository({required this.userDatabaseServiceIMP});

  final IUserDatabaseService userDatabaseServiceIMP;
  

  @override
  Future<String?> pegarBio() async {
     await userDatabaseServiceIMP.;
  }

  @override
  Future<String?> pegarContribuicoes() async {
    // TODO: implement pegarContribuicoes
    throw UnimplementedError();
  }

  @override
  Future<String?> pegarFoto() async {
    // TODO: implement pegarFoto
    throw UnimplementedError();
  }

  @override
  Future<String?> pegarSeguidores() async {
    // TODO: implement pegarSeguidores
    throw UnimplementedError();
  }

} 