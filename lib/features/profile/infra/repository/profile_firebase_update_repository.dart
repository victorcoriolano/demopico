import 'package:demopico/features/profile/domain/interfaces/i_profile_database_update_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_database_update_service.dart';
import 'package:demopico/features/profile/infra/datasource/firebase_profile_update_datasource.dart';
import 'package:demopico/features/user/domain/models/user.dart';

class ProfileFirebaseUpdateRepository
    implements IProfileDatabaseUpdateRepository {
  static ProfileFirebaseUpdateRepository? _profileFirebaseUpdateRepository;

 static ProfileFirebaseUpdateRepository get getInstance {
    _profileFirebaseUpdateRepository ??= ProfileFirebaseUpdateRepository(
        profileDatabaseUpdateServiceIMP:
            ProfileFirebaseUpdateService.getInstance);
    return _profileFirebaseUpdateRepository!;
  }

  ProfileFirebaseUpdateRepository(
      {required this.profileDatabaseUpdateServiceIMP});

  final IProfileDatabaseUpdateService profileDatabaseUpdateServiceIMP;

  @override
  void atualizarBio(String newBio, UserM user) async {
    String uid = user.id!;
    profileDatabaseUpdateServiceIMP.atualizarBio(newBio, uid);
  }

  @override
  void atualizarContribuicoes(UserM user) async {
    String uid = user.id!;
    profileDatabaseUpdateServiceIMP.atualizarContribuicoes(uid);
  }

  @override
  void atualizarFoto(String newFoto, UserM user) async {
    String uid = user.id!;
    profileDatabaseUpdateServiceIMP.atualizarFoto(newFoto, uid);
  }

  @override
  void atualizarSeguidores(UserM user) async {
    String uid = user.id!;
    profileDatabaseUpdateServiceIMP.atualizarSeguidores(uid);
  }
}
