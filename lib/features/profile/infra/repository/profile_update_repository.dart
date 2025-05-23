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
  void updateBio(String newBio, UserM user) async {
    String uid = user.id!;
    databaseProfileUpdateServiceIMP.updateBio(newBio, uid);
  }

  @override
  void updateContributions(UserM user) async {
    String uid = user.id!;
    databaseProfileUpdateServiceIMP.updateContributions(uid);
  }

  @override
  void updatePhoto(String newFoto, UserM user) async {
    String uid = user.id!;
    databaseProfileUpdateServiceIMP.updatePhoto(newFoto, uid);
  }

  @override
  void updateFollowers(UserM user) async {
    String uid = user.id!;
    databaseProfileUpdateServiceIMP.updateFollowers(uid);
  }
}
