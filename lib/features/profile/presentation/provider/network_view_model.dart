import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/domain/usecases/get_sugestions_user_uc.dart';
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

  List<UserM> sugestions = [];  

  Future<void> fetchSugestions(String userId) async {
    try{
      sugestions = await _getSugestionsUser.call(userId);
    } on Failure catch (e) {
      FailureServer.showError(e);
    } 
    notifyListeners();
  }
}