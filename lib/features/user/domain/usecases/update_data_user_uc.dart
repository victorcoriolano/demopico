
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';

class UpdateDataUserUc {
  final IUserDataRepository _repository;

  UpdateDataUserUc({required IUserDataRepository repository})
      : _repository = repository;

  Future<void> call(UserM user) async {
    await _repository.updateUserDetails(user);
  }
}