import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/infra/repositories/user_firebase_repository.dart';

class EmailUserByVulgoUc {
  static EmailUserByVulgoUc? _emailUserByVulgoUc;
  static EmailUserByVulgoUc get getInstance {
    _emailUserByVulgoUc ??= EmailUserByVulgoUc(
      userDatabaseRepositoryIMP: UserFirebaseRepository.getInstance,
    );
    return _emailUserByVulgoUc!;
  }

  final IUserDatabaseRepository userDatabaseRepositoryIMP;

  EmailUserByVulgoUc({required this.userDatabaseRepositoryIMP});

  Future<String?> getEmail(String vulgo) async {
    try {
      return await userDatabaseRepositoryIMP.getEmailByVulgo(vulgo);
    } catch (e) {
      return null;
    }
  }
}
