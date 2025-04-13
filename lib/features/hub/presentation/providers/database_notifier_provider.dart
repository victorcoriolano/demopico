import 'package:demopico/features/hub/infra/services/database_service.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/user/data/models/user.dart';
import 'package:demopico/features/user/data/services/userService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HubProvider extends ChangeNotifier {
  final _db = HubService();
  final  UserService _userService = UserService();

  void notify() {
    notifyListeners();
  }

  Future<UserM?> retrieveUserProfileData(String uid) =>
      _userService.getUserDetailsFromFirestore(uid);

  List<Communique> _allCommuniques = [];

  List<Communique> get allCommuniques => _allCommuniques;

  Future<void> postHubCommunique(String text, String type) async {
    await _db.postHubCommuniqueToFirebase(text, type);
    getAllCommuniques();
  }

  Future<void> getAllCommuniques() async {
    final allCommuniquesFromDb = await _db.getAllCommuniques();
    _allCommuniques = allCommuniquesFromDb;
    notifyListeners();
  }
}
