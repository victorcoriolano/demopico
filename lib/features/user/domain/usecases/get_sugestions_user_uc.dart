
import 'package:demopico/features/user/domain/interfaces/i_user_database_repository.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/repositories/user_data_repository_impl.dart';
import 'package:flutter/cupertino.dart';

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
    if (user.connections.isEmpty) {
      //não tem conexões então a lista de sugestões será a lista de usuários
      final listUsers = await _repository.getUsers();
      debugPrint("Lista de usuários: ${listUsers.length}");
      listUsers.remove(user);
      debugPrint("Lista de usuários após remover o usuário atual: ${listUsers.length} - removeu $user");
      return listUsers;
    }
    return await _repository.getSuggestions(user.connections);
  }
}