import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/profile/presentation/object_for_only_view/suggestion_profile.dart';
import 'package:flutter/material.dart';

class CreateCollectiveViewModel extends ChangeNotifier {

  CreateCollectiveViewModel();

  List<UserIdentification> members = [];

  void addMember(SuggestionProfile suggestion){
    final user = UserIdentification(
      id: suggestion.idUser, name: suggestion.name, profilePictureUrl: suggestion.photo);
    if (members.contains(user)) return;
    members.add(user);
    notifyListeners();
  }

  void removeMember(UserIdentification user){
    members.remove(user);
    notifyListeners();
  }
}