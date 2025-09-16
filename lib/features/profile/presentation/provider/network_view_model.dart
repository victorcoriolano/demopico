import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/domain/usecases/accept_connection_uc.dart';
import 'package:demopico/features/profile/domain/usecases/cancel_relationship_uc.dart';
import 'package:demopico/features/profile/domain/usecases/create_connection_users_uc.dart';
import 'package:demopico/features/profile/domain/usecases/get_connections_requests_uc.dart';
import 'package:demopico/features/profile/domain/usecases/get_connections_sent.dart';
import 'package:demopico/features/profile/presentation/view_objects/suggestion_profile.dart';
import 'package:demopico/features/user/domain/usecases/get_sugestions_user_uc.dart';
import 'package:demopico/features/user/presentation/controllers/profile_view_model.dart';
import 'package:flutter/material.dart';

class NetworkViewModel extends ChangeNotifier {
  final GetSugestionsUserUc _getSugestionsUser;
  final CreateConnectionUsersUc _createConnectionUsers;
  final GetConnectionsRequestsUc _getConnectionsRequests;
  final AcceptConnectionUc _acceptConnection;
  final GetConnectionsSentUc _getConnectionsSent;
  final CancelRelationshipUc _cancelRelationship;

  static NetworkViewModel? _instance;
  static NetworkViewModel get instance {
    _instance ??= NetworkViewModel(
        createConnectionUsers: CreateConnectionUsersUc.instance,
        getSugestionsUser: GetSugestionsUserUc.instance,
        getConnectionsRequests: GetConnectionsRequestsUc.instance,
        acceptConnection: AcceptConnectionUc.instance,
        getConnectionsSent: GetConnectionsSentUc.instance,
        cancelRelationship: CancelRelationshipUc.instance);
    return _instance!;
  }

  NetworkViewModel({
    required CancelRelationshipUc cancelRelationship,
    required GetConnectionsSentUc getConnectionsSent,
    required GetSugestionsUserUc getSugestionsUser,
    required CreateConnectionUsersUc createConnectionUsers,
    required GetConnectionsRequestsUc getConnectionsRequests,
    required AcceptConnectionUc acceptConnection,
  })  : _getSugestionsUser = getSugestionsUser,
        _getConnectionsSent = getConnectionsSent,
        _createConnectionUsers = createConnectionUsers,
        _getConnectionsRequests = getConnectionsRequests,
        _acceptConnection = acceptConnection,
        _cancelRelationship = cancelRelationship;

  List<SuggestionProfile> _suggestions = [];
  List<ConnectionRequester> _connectionsRequests = [];
  List<ConnectionReceiver> _connectionSent = [];

  List<SuggestionProfile> get suggestions => _suggestions;
  List<ConnectionRequester> get connectionRequests => _connectionsRequests;
  List<ConnectionReceiver> get connectionSent => _connectionSent;

  Future<void> fetchConnectionsRequests() async {
    final user = UserDataViewModel.getInstance.user;
    if (user == null) return;

    try {
      _connectionsRequests = await _getConnectionsRequests.execute(user.id);
      debugPrint("Connections Requests: ${_connectionsRequests.length}");
      notifyListeners();
    } on Failure catch (e) {
      FailureServer.showError(e, "Error fetching connections requests");
    }
  }

  Future<void> fetchConnectionSent() async {
    final user = UserDataViewModel.getInstance.user;
    if (user == null) return;

    try {
      _connectionSent = await _getConnectionsSent.execute(user.id);
      debugPrint("Connections Sent: ${_connectionSent.length}");
      notifyListeners();
    } on Failure catch (e) {
      FailureServer.showError(e, "Error fetching connections sent");
    }
  }

  Future<void> fetchSugestions() async {
    final user = UserDataViewModel.getInstance.user;
    if (user == null) return;

    try {
      _suggestions = await _getSugestionsUser.execute(user.id);
      notifyListeners();
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
    notifyListeners();
  }

  Future<void> requestConnection(SuggestionProfile userSuggestion) async {
    final userLogged = UserDataViewModel.getInstance.user;
    if (userLogged == null) return;

    _suggestions
        .firstWhere((element) => element == userSuggestion)
        .updateConnection(RequestConnectionStatus.pending);

    final connection = Relationship(
      id: '',
      requesterUser: ConnectionRequester(
          id: userLogged.id,
          name: userLogged.name,
          profilePictureUrl: userLogged.pictureUrl),
      addressed: ConnectionReceiver(
          id: userSuggestion.idUser,
          name: userSuggestion.name,
          profilePictureUrl: userSuggestion.photo),
      status: RequestConnectionStatus.pending,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    try {
      await _createConnectionUsers.execute(connection, userLogged);
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
    notifyListeners();
  }

  Future<void> acceptConnection(Relationship connection) async {
    try {
      final userLogged = UserDataViewModel.getInstance.user;
      if (userLogged == null) return;

      await _acceptConnection.execute(connection);
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
    notifyListeners();
  }

  Future<void> cancelRelationship(Relationship connection) async {
    try {
      final userLogged = UserDataViewModel.getInstance.user;
      if (userLogged == null) return;

      await _cancelRelationship.execute(connection);
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
    notifyListeners();
  }
}
