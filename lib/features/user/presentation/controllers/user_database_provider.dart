import 'package:demopico/features/user/domain/models/user.dart';
import 'package:flutter/material.dart';

class UserDatabaseProvider extends ChangeNotifier {
  
  static UserDatabaseProvider? _userDatabaseProvider;

  static UserDatabaseProvider get getInstance{
    _userDatabaseProvider ??= UserDatabaseProvider();
    return _userDatabaseProvider!;
  }

  

  Future<UserM?> retrieveUserProfileData(String uid) =>
      _db.getUserDetailsFromFirestore(uid);

  Future<void> updateUserBio(String newBio) =>
      _db.updateUserBioInFirebase(newBio);

}
