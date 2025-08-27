
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';

class GetSugestionsUserUc {
  final IUserDataRepository _repository;

  static GetSugestionsUserUc? _instance;
  static GetSugestionsUserUc get instance {
    _instance ??= GetSugestionsUserUc(
      repository: UserDataRepositoryImpl.getInstance,
    );
    return _instance!;
  }

  GetSugestionsUserUc({required IUserDataRepository repository})
      : _repository = repository;

  Future<List<UserM>> execute(UserM user) async {
    if (user.connections.length < 10) {
      final listUsers = await _repository.getSuggestionsProfileExcept(user.id);
      return listUsers;
    }
    final listExcept = user.connections;
    listExcept.add(user.id);

    final suggestions  = await _repository.getSuggestionsExceptConnections(listExcept.toSet());
    return suggestions;
  }
}