import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/infra/repositories/user_firebase_repository.dart';

class EmailUserByIDUc {
  static EmailUserByIDUc? _emailUserByIDUc;
  static EmailUserByIDUc get getInstance {
    _emailUserByIDUc ??= EmailUserByIDUc(
      userDatabaseRepositoryIMP: UserFirebaseRepository.getInstance,
    );
    return _emailUserByIDUc!;
  }

  final IUserDatabaseRepository userDatabaseRepositoryIMP;

  EmailUserByIDUc({required this.userDatabaseRepositoryIMP});

  Future<String?> getEmail(String uid) async {
    try {
      return await userDatabaseRepositoryIMP.getEmailByUserID(uid);
    } catch (e) {
      return null;
    }
  }
}
