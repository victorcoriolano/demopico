import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/infra/repositories/user_firebase_repository.dart';

class IDUserByVulgoUc {
  static IDUserByVulgoUc? _idUserByVulgoUc;
  static IDUserByVulgoUc get getInstance {
    _idUserByVulgoUc ??= IDUserByVulgoUc(
      userDatabaseRepositoryIMP: UserFirebaseRepository.getInstance,
    );
    return _idUserByVulgoUc!;
  }

  final IUserDatabaseRepository userDatabaseRepositoryIMP;

  IDUserByVulgoUc({required this.userDatabaseRepositoryIMP});

  Future<String?> getID(String vulgo) async {
    try {
      return await userDatabaseRepositoryIMP.getUserIDByVulgo(vulgo);
    } catch (e) {
      return null;
    }
  }
}
