
import 'package:demopico/core/common/auth/domain/interfaces/i_user_account_repository.dart';

class DeleteAccountUc {
  final IUserAccountRepository _accountRepository;

  DeleteAccountUc({required IUserAccountRepository accountRepository})
    : _accountRepository = accountRepository;

  Future<void> execute() async {
    return await _accountRepository.deleteAccount();
  }
}