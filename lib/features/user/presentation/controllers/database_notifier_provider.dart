import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/user/data/models/user.dart';
import 'package:demopico/features/user/data/services/database_service.dart';
import 'package:flutter/material.dart';

class DatabaseProvider extends ChangeNotifier {
  final _db = DatabaseService();

  void notify() {
    notifyListeners();
  }

  Future<UserM?> retrieveUserProfileData(String uid) =>
      _db.getUserDetailsFromFirestore(uid);

  Future<void> updateUserBio(String newBio) =>
      _db.updateUserBioInFirebase(newBio);

  Future<void> updateUserImg(String newImg) =>
  _db.updateUserImgInFirebase(newImg);  

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
