import 'package:demopico/features/profile/domain/interfaces/i_profile_update_repository.dart';
import 'package:demopico/features/profile/domain/interfaces/i_profile_update_datasource.dart';
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

  final IProfileUpdateDatasource databaseProfileUpdateServiceIMP;

  @override
  Future<void> updateBio(String newBio, UserM user) async {
    String uid = user.id!;
    await databaseProfileUpdateServiceIMP.updateBio(newBio, uid);
  }

  @override
  Future<void> updateContributions(UserM user) async {
    String uid = user.id!;
    await databaseProfileUpdateServiceIMP.updateContributions(uid);
  }

  @override
  Future<void> updatePhoto(String newFoto, UserM user) async {
    String uid = user.id!;
    await databaseProfileUpdateServiceIMP.updatePhoto(newFoto, uid);
  }

  @override
  Future<void> updateFollowers(UserM user) async {
    String uid = user.id!;
    await databaseProfileUpdateServiceIMP.updateFollowers(uid);
  }
}
