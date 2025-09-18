
import 'package:demopico/core/common/auth/domain/interfaces/i_user_repository.dart';
import 'package:demopico/features/user/domain/models/user_model.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';

class UpdateUserUc {
  final IUserRepository _repository;

  static UpdateUserUc? _instance;
  static UpdateUserUc get getInstance {
    _instance ??= UpdateUserUc(repository: UserDataRepositoryImpl.getInstance);
    return _instance!;
  }

  UpdateUserUc({required IUserRepository repository})
      : _repository = repository;

  Future<void> call(UserM user) async {
    await _repository.update(user);
  }
}