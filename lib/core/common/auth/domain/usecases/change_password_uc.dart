
import 'package:demopico/core/common/auth/domain/interfaces/i_user_account_repository.dart';
import 'package:demopico/core/common/auth/infra/repositories/firebase_account_repository.dart';

class ChangePasswordUc {
  static ChangePasswordUc? _changePasswordUc;
  static ChangePasswordUc get getInstance {
  _changePasswordUc ??= ChangePasswordUc(accountRepository: FirebaseAccountRepository.instance);
    return _changePasswordUc!;
  }

  final IUserAccountRepository _accountRepository;

  ChangePasswordUc({required IUserAccountRepository accountRepository}) 
    : _accountRepository = accountRepository;

  Future<bool> sendEmail() async {
    return await _accountRepository.changePassWord();
  } 
}