import 'package:demopico/features/hub/data/infra/database_service.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/user/data/models/user.dart';
import 'package:flutter/material.dart';

class HubProvider extends ChangeNotifier {
  final _db = HubService();

  void notify() {
    notifyListeners();
  }

  Future<UserM?> retrieveUserProfileData(String uid) =>
      _db.getUserDetailsFromFirestore(uid);

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
