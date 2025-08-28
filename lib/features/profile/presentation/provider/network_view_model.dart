import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/profile/domain/models/connection.dart';
import 'package:demopico/features/profile/domain/usecases/accept_connection_uc.dart';
import 'package:demopico/features/profile/domain/usecases/create_connection_users_uc.dart';
import 'package:demopico/features/profile/domain/usecases/get_connections_requests_uc.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/domain/usecases/get_sugestions_user_uc.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:flutter/material.dart';

class NetworkViewModel extends ChangeNotifier {
  final GetSugestionsUserUc _getSugestionsUser;
  final CreateConnectionUsersUc _createConnectionUsers;
  final GetConnectionsRequestsUc _getConnectionsRequests;
  final AcceptConnectionUc _acceptConnection;     


  static NetworkViewModel? _instance;
  static NetworkViewModel get instance {
    _instance ??= NetworkViewModel(
      createConnectionUsers: CreateConnectionUsersUc.instance,
      getSugestionsUser: GetSugestionsUserUc.instance,
      getConnectionsRequests: GetConnectionsRequestsUc.instance,
      acceptConnection: AcceptConnectionUc.instance,
    );
    return _instance!;
  }

  NetworkViewModel({
    required GetSugestionsUserUc getSugestionsUser,
    required CreateConnectionUsersUc createConnectionUsers,
    required GetConnectionsRequestsUc getConnectionsRequests,
    required AcceptConnectionUc acceptConnection,
  })  : _getSugestionsUser = getSugestionsUser,
        _createConnectionUsers = createConnectionUsers,
        _getConnectionsRequests = getConnectionsRequests,
        _acceptConnection = acceptConnection;

  List<UserM> get sugestions => _sugestions;
  List<Connection> get connections => _connectionsRequests;

  List<UserM> _sugestions = [];  
  List<Connection> _connectionsRequests = [];

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

  Future<void> fetchConnections(UserM user) async {
    final userLogged = UserDatabaseProvider.getInstance.user;
    if (userLogged == null) return;

    try {
      _connectionsRequests = await _getConnectionsRequests.execute(userLogged.id);
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
      updatedAt: DateTime.now(),
    );

    try{
      await _createConnectionUsers.execute(connection);
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
    notifyListeners();
  }

  Future<void> acceptConnection(Connection connection) async {
    try {
      
      await _acceptConnection.execute(connection);
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
    notifyListeners();
  }
}