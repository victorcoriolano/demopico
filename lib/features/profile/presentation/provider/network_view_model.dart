import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/profile/domain/models/connection.dart';
import 'package:demopico/features/profile/domain/usecases/create_connection_users_uc.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/domain/usecases/get_sugestions_user_uc.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:flutter/material.dart';

class NetworkViewModel extends ChangeNotifier {
  final GetSugestionsUserUc _getSugestionsUser;
  final CreateConnectionUsersUc _createConnectionUsers;


  static NetworkViewModel? _instance;
  static NetworkViewModel get instance {
    _instance ??= NetworkViewModel(
      createConnectionUsers: CreateConnectionUsersUc.instance,
      getSugestionsUser: GetSugestionsUserUc.instance,
    );
    return _instance!;
  }

  NetworkViewModel({required GetSugestionsUserUc getSugestionsUser, required CreateConnectionUsersUc createConnectionUsers})
      : _getSugestionsUser = getSugestionsUser,
        _createConnectionUsers = createConnectionUsers;

  List<UserM> get sugestions => _sugestions;

  List<UserM> _sugestions = [];  

  Future<void> fetchSugestions() async {
    final user = UserDatabaseProvider.getInstance.user;
    if (user == null) return;

    try{
      _sugestions = await _getSugestionsUser.execute(user);
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
    notifyListeners();
  }

  Future<void> createConnections(UserM user) async {
    final userLogged = UserDatabaseProvider.getInstance.user;
    if (userLogged == null) return;

    final connection = Connection(
      id: '',
      userID: userLogged.id,
      connectedUserID: user.id,
      status: RequestConnectionStatus.pending,
      createdAt: DateTime.now(),
    );

    try{
      await _createConnectionUsers.execute(connection);
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
    notifyListeners();
  }
}