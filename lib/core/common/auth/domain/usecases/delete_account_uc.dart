
import 'package:demopico/core/common/auth/domain/interfaces/i_user_account_repository.dart';
import 'package:demopico/core/common/auth/infra/repositories/firebase_account_repository.dart';

class DeleteAccountUc {
    static DeleteAccountUc? _deleteAccountUc;
  static DeleteAccountUc get getInstance {
  _deleteAccountUc ??= DeleteAccountUc(accountRepository: FirebaseAccountRepository.instance);
    return _deleteAccountUc!;
  }
  final IUserAccountRepository _accountRepository;

  DeleteAccountUc({required IUserAccountRepository accountRepository})
    : _accountRepository = accountRepository;

  Future<void> execute() async {
    return await _accountRepository.deleteAccount();
  }
}