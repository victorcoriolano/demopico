
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';

class UpdateDataUserUc {
  final IUserDataRepository _repository;

  static UpdateDataUserUc? _instance;
  static UpdateDataUserUc get getInstance {
    _instance ??= UpdateDataUserUc(repository: UserDataRepositoryImpl.getInstance);
    return _instance!;
  }

  UpdateDataUserUc({required IUserDataRepository repository})
      : _repository = repository;

  Future<void> call(UserM user) async {
    await _repository.updateUserDetails(user);
  }
}