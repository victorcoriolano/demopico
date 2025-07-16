import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/infra/repositories/user_firebase_repository.dart';
import 'package:flutter/foundation.dart';

class EmailUserByIDUc {
  static EmailUserByIDUc? _emailUserByIDUc;
  static EmailUserByIDUc get getInstance {
    _emailUserByIDUc ??= EmailUserByIDUc(
      userDatabaseRepositoryIMP: UserRepositoryImpl.getInstance,
    );
    return _emailUserByIDUc!;
  }

  final IUserDatabaseRepository userDatabaseRepositoryIMP;

  EmailUserByIDUc({required this.userDatabaseRepositoryIMP});

  Future<String> getEmail(String uid) async {
    try {
      return await userDatabaseRepositoryIMP.getEmailByUserID(uid);
    } on Failure catch (e) {
      debugPrint("UC - Erro ao pegar o email: $e");
      rethrow;
    }
  }
}
