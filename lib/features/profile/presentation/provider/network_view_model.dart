import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/domain/usecases/get_sugestions_user_uc.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:flutter/material.dart';

class NetworkViewModel extends ChangeNotifier {
  final GetSugestionsUserUc _getSugestionsUser;

  static NetworkViewModel? _instance;
  static NetworkViewModel get instance {
    _instance ??= NetworkViewModel(
      getSugestionsUser: GetSugestionsUserUc.instance,
    );
    return _instance!;
  }

  NetworkViewModel({required GetSugestionsUserUc getSugestionsUser})
      : _getSugestionsUser = getSugestionsUser;

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
}