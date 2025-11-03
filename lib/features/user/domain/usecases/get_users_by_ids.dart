
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/core/common/auth/infra/mapper/user_mapper.dart';
import 'package:demopico/features/user/domain/interfaces/i_users_repository.dart';
import 'package:demopico/features/user/domain/models/user_model.dart';
import 'package:demopico/features/user/infra/repositories/users_repository.dart';

class GetUsersByIds {
  final IUsersRepository _repository;

  GetUsersByIds() : _repository = UsersRepository.getInstance;

  Future<List<UserIdentification>> execute(List<String> ids) async {
    final users = await _repository.getUsersByIds(ids);
    return users.map((user) => UserMapper.mapUserModelToUserIdentification(user)).toList();
  }
}