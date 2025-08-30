
import 'package:demopico/features/profile/presentation/view_objects/suggestion_profile.dart';
import 'package:demopico/features/user/domain/interfaces/i_users_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/users_repository.dart';

class GetSugestionsUserUc {
  final IUsersRepository _repository;

  static GetSugestionsUserUc? _instance;
  static GetSugestionsUserUc get instance {
    _instance ??= GetSugestionsUserUc(
      repository: UsersRepository.getInstance,
    );
    return _instance!;
  }

  GetSugestionsUserUc({required IUsersRepository repository})
      : _repository = repository;

  Future<List<SuggestionProfile>> execute(UserM user) async {
    if (user.connections.isEmpty) {
      final listUsers = await _repository.getSuggestionsProfileExcept(user.id);
      return listUsers.map((user) {
        return SuggestionProfile.fromUser(user);
      }).toList();
    }
    final listExcept = user.connections;
    listExcept.add(user.id);

    final suggestions  = await _repository.getSuggestionsExceptConnections(listExcept.toSet());
    return suggestions.map((user) {
      return SuggestionProfile.fromUser(user);
    }).toList();
  }
}