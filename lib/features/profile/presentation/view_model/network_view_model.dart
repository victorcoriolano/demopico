import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/profile/domain/usecases/accept_connection_uc.dart';
import 'package:demopico/features/profile/domain/usecases/cancel_relationship_uc.dart';
import 'package:demopico/features/profile/domain/usecases/create_connection_users_uc.dart';
import 'package:demopico/features/profile/domain/usecases/get_conections_accepted_uc.dart';
import 'package:demopico/features/profile/domain/usecases/get_connections_requests_uc.dart';
import 'package:demopico/features/profile/domain/usecases/get_connections_sent.dart';
import 'package:demopico/features/profile/presentation/view_objects/suggestion_profile.dart';
import 'package:demopico/features/user/domain/usecases/get_sugestions_user_uc.dart';
import 'package:flutter/material.dart';

class NetworkViewModel extends ChangeNotifier {
  //usecases 
  final GetSugestionsUserUc _getSugestionsUser;
  final CreateConnectionUsersUc _createConnectionUsers;
  final GetConnectionsRequestsUc _getConnectionsRequests;
  final AcceptConnectionUc _acceptConnection;
  final GetConnectionsSentUc _getConnectionsSent;
  final CancelRelationshipUc _cancelRelationship;
  final GetConectionsAcceptedUc _getConnAcceptedUc;

  static NetworkViewModel? _instance;
  static NetworkViewModel get instance {
    _instance ??= NetworkViewModel(
        getConnAccUC: GetConectionsAcceptedUc.instance,
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
    required GetConectionsAcceptedUc getConnAccUC,
  })  : _getSugestionsUser = getSugestionsUser,
        _getConnAcceptedUc = getConnAccUC,
        _getConnectionsSent = getConnectionsSent,
        _createConnectionUsers = createConnectionUsers,
        _getConnectionsRequests = getConnectionsRequests,
        _acceptConnection = acceptConnection,
        _cancelRelationship = cancelRelationship;

  List<SuggestionProfile> _suggestions = [];
  List<Relationship> _connectionsRequests = [];
  List<Relationship> _connectionSent = [];
  List<Relationship> _connectionsAccepted = [];

  List<SuggestionProfile> get suggestions => _suggestions;
  List<BasicInfoUser> get connectionRequests => _connectionsRequests.map((conn) => conn.requesterUser).toList();
  List<BasicInfoUser> get connectionSent => _connectionSent.map((conn) => conn.addressed).toList();
  List<BasicInfoUser> connAccepted(String idUser) => 
    _connectionsAccepted.map((e) {
      return e.addressed.id == idUser 
        ?  e.requesterUser
        :  e.addressed;
    }).toList();

  Future<void> fetchRelactionships(UserEntity user) async {
    try {
      _connectionsRequests = await _getConnectionsRequests.execute(user.id);
      _connectionSent = await _getConnectionsSent.execute(user.id);
      _connectionsAccepted = await _getConnAcceptedUc.execute(user.id);
      notifyListeners();
    } on Failure catch (e) {
      FailureServer.showError(e, "Error fetching connections requests");
    }
  }

  Future<void> fetchSugestions(UserEntity currentUser) async {
    try {
      _suggestions = await _getSugestionsUser.execute(currentUser.id);
      notifyListeners();
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
    notifyListeners();
  }

  Future<void> requestConnection(SuggestionProfile userSuggestion, UserEntity currentUser) async {
    _suggestions
        .firstWhere((element) => element == userSuggestion)
        .updateConnection(RequestConnectionStatus.pending);

    final connection = Relationship(
      id: '',
      requesterUser: BasicInfoUser(
          id: currentUser.id,
          name: currentUser.displayName.value,
          profilePictureUrl: currentUser.avatar),
      addressed: BasicInfoUser(
          id: userSuggestion.idUser,
          name: userSuggestion.name,
          profilePictureUrl: userSuggestion.photo),
      status: RequestConnectionStatus.pending,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    try {
      await _createConnectionUsers.execute(connection);
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
    notifyListeners();
  }


  Future<void> acceptConnection(BasicInfoUser requester, UserEntity currentUser) async {
    try {
      suggestions.removeWhere((suggestion) => suggestion.idUser == requester.id);
      final relationshiptoUpdate = _connectionsRequests.firstWhere((relactionship) => relactionship.requesterUser == requester);
      final connection = relationshiptoUpdate.copyWith(status: RequestConnectionStatus.accepted);
      await _acceptConnection.execute(connection);
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
    notifyListeners();
  }

  Future<void> cancelRelationship(BasicInfoUser request) async {
    try {
      final relationship = _connectionSent.firstWhere((relatioship) => relatioship.addressed == request);
      await _cancelRelationship.execute(relationship);
    } on Failure catch (e) {
      FailureServer.showError(e);
    }
    notifyListeners();
  }
}
