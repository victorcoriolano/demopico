import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/domain/usecases/accept_connection_uc.dart';
import 'package:demopico/features/profile/domain/usecases/create_connection_users_uc.dart';
import 'package:demopico/features/profile/domain/usecases/get_connections_requests_uc.dart';
import 'package:demopico/features/profile/presentation/view_objects/suggestion_profile.dart';
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

  List<SuggestionProfile> get suggestions => _suggestions;
  List<UserM> get connectionRequests => _connectionsRequests;
  List<UserM> get connectionSent => _connectionSent;

  List<SuggestionProfile> _suggestions = [];
  List<UserM> _connectionsRequests = [];
  final List<UserM> _connectionSent = [];

  Future<void> fetchConnectionsRequests() async {
    final user = UserDatabaseProvider.getInstance.user;
    if (user == null) return;

    try{
      _connectionsRequests = await _getConnectionsRequests.execute(user.id);
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
  }

  Future<void> fetchSugestions() async {
    final user = UserDatabaseProvider.getInstance.user;
    if (user == null) return;

    try{
      _suggestions = await _getSugestionsUser.execute(user.id);
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
    notifyListeners();
  }

  Future<void> fetchConnections() async {
    final userLogged = UserDatabaseProvider.getInstance.user;
    if (userLogged == null) return;

    try {
      _connectionsRequests = await _getConnectionsRequests.execute(userLogged.id);
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
    notifyListeners();
  }

  Future<void> requestConnection(SuggestionProfile userSuggestion) async {
    final userLogged = UserDatabaseProvider.getInstance.user;
    if (userLogged == null) return;

    _suggestions.firstWhere((element) => element == userSuggestion).updateConnection(RequestConnectionStatus.pending);

    final connection = Relationship(
      id: '',
      requesterUserID: userLogged.id,
      addresseeID: userSuggestion.idUser,
      status: RequestConnectionStatus.pending,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    try{
      await _createConnectionUsers.execute(connection, userLogged);
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
    notifyListeners();
  }

  Future<void> acceptConnection(Relationship connection) async {
    try {
      final userLogged = UserDatabaseProvider.getInstance.user;
    if (userLogged == null) return;

      

      await _acceptConnection.execute(connection);
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
    notifyListeners();
  }
}