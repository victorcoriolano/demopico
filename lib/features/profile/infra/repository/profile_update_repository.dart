import 'package:demopico/features/profile/domain/interfaces/i_profile_update_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_update_service.dart';
import 'package:demopico/features/profile/infra/datasource/firebase_profile_update_datasource.dart';
import 'package:demopico/features/user/domain/models/user.dart';

class ProfileUpdateRepository
    implements IProfileUpdateRepository {
  static ProfileUpdateRepository? _profileUpdateRepository;

 static ProfileUpdateRepository get getInstance {
    _profileUpdateRepository ??= ProfileUpdateRepository(
        databaseProfileUpdateServiceIMP:
            FirebaseProfileUpdateDatasource.getInstance);
    return _profileUpdateRepository!;
  }

  ProfileUpdateRepository(
      {required this.databaseProfileUpdateServiceIMP});

  final IProfileDatabaseUpdateService databaseProfileUpdateServiceIMP;

  @override
  void atualizarBio(String newBio, UserM user) async {
    String uid = user.id!;
    databaseProfileUpdateServiceIMP.atualizarBio(newBio, uid);
  }

  @override
  void atualizarContribuicoes(UserM user) async {
    String uid = user.id!;
    databaseProfileUpdateServiceIMP.atualizarContribuicoes(uid);
  }

  @override
  void atualizarFoto(String newFoto, UserM user) async {
    String uid = user.id!;
    databaseProfileUpdateServiceIMP.atualizarFoto(newFoto, uid);
  }

  @override
  void atualizarSeguidores(UserM user) async {
    String uid = user.id!;
    databaseProfileUpdateServiceIMP.atualizarSeguidores(uid);
  }
}
