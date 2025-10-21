
import 'package:demopico/core/common/auth/domain/interfaces/i_user_account_repository.dart';
import 'package:demopico/core/common/auth/domain/value_objects/password_vo.dart';
import 'package:demopico/core/common/auth/infra/repositories/firebase_account_repository.dart';

class UpdatePasswordUc {
  static UpdatePasswordUc? _changePasswordUc;
  static UpdatePasswordUc get getInstance {
  _changePasswordUc ??= UpdatePasswordUc(accountRepository: FirebaseAccountRepository.instance);
    return _changePasswordUc!;
  }

  final IUserAccountRepository _accountRepository;

  UpdatePasswordUc({required IUserAccountRepository accountRepository}) 
    : _accountRepository = accountRepository;

  Future<void> execute(PasswordVo newPassword) async {
    return await _accountRepository.updatePassword(newPassword);
  } 
}