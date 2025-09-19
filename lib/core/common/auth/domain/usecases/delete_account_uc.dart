
import 'package:demopico/features/profile/domain/interfaces/i_profile_repository.dart';
import 'package:demopico/core/common/auth/domain/interfaces/i_user_account_repository.dart';
import 'package:demopico/core/common/auth/domain/interfaces/i_user_repository.dart';
import 'package:demopico/core/common/auth/infra/repositories/firebase_account_repository.dart';
import 'package:demopico/features/profile/infra/repository/profile_repository.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';

class DeleteAccountUc {
    static DeleteAccountUc? _deleteAccountUc;
  static DeleteAccountUc get getInstance {
  _deleteAccountUc ??= DeleteAccountUc(
    accountRepository: FirebaseAccountRepository.instance,
    userRepostory: UserDataRepositoryImpl.getInstance,
    profileRepository: ProfileRepositoryImpl.instance);
    return _deleteAccountUc!;
  }
  final IUserAccountRepository _accountRepository;
  final IProfileRepository _profileRepository;
  final IUserRepository _userRepository;

  DeleteAccountUc({
    required IUserAccountRepository accountRepository,
    required IProfileRepository profileRepository,
    required IUserRepository userRepostory,
  })
    : _accountRepository = accountRepository,
      _profileRepository = profileRepository,
      _userRepository = userRepostory;

  Future<void> execute(String idUser) async {
     await _accountRepository.deleteAccount();
     await _profileRepository.deleteProfile(idUser);
     await _userRepository.deleteData(idUser);
  }
}