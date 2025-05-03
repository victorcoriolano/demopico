import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:demopico/features/user/domain/models/user.dart';
import 'package:demopico/features/user/infra/services/database_service.dart';
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

}
