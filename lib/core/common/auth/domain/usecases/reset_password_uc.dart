
import 'package:demopico/core/common/auth/domain/interfaces/i_user_account_repository.dart';
import 'package:demopico/core/common/auth/infra/repositories/firebase_account_repository.dart';

class ResetPasswordUc {
  static ResetPasswordUc? _changePasswordUc;
  static ResetPasswordUc get getInstance {
  _changePasswordUc ??= ResetPasswordUc(accountRepository: FirebaseAccountRepository.instance);
    return _changePasswordUc!;
  }

  final IUserAccountRepository _accountRepository;

  ResetPasswordUc({required IUserAccountRepository accountRepository}) 
    : _accountRepository = accountRepository;

  Future<bool> sendEmail(String email) async {
    return await _accountRepository.resetPassword(email);
  } 
}