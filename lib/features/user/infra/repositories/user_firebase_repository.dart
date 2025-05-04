import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/services/user_firebase_service.dart';

class UserFirebaseRepository implements IUserDatabaseRepository {
  static UserFirebaseRepository? _userFirebaseRepository;

  UserFirebaseRepository get getInstance {
    _userFirebaseRepository ??= UserFirebaseRepository(
        userFirebaseService: UserFirebaseService.getInstance);
    return _userFirebaseRepository!;
  }

  UserFirebaseRepository({required this.userFirebaseService});

  final UserFirebaseService userFirebaseService;

  @override
  Future<void> addUserDetails(UserM newUser) async {
    String uid = newUser.id!;
    await userFirebaseService.addUserDetails(newUser, uid);
  }

  @override
  Future<String?> getEmailByUserID(String uid) async {
    return await userFirebaseService.getEmailByUserID(uid);
  }

  @override
  Future<UserM?> getUserDetails(String uid) async {
    return await userFirebaseService.getUserDetails(uid);
  }

  @override
  Future<String?> getUserIDByVulgo(String vulgo) async {
    return await userFirebaseService.getUserIDByVulgo(vulgo);
  }
}
