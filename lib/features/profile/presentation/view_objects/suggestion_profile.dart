

import 'package:demopico/core/common/auth/domain/entities/profile_user.dart';
import 'package:demopico/features/profile/domain/models/relationship.dart';
import 'package:demopico/features/user/domain/models/user_model.dart';

class SuggestionProfile {
  final String idUser;
  final String name;
  final String? photo;
  RequestConnectionStatus status;

  SuggestionProfile({
    required this.idUser,
    required this.name,
    required this.photo,
    required this.status,
  });

  factory SuggestionProfile.fromUser(Profile user) {
    return SuggestionProfile(
      idUser: user.userID,
      name: user.displayName,
      photo: user.avatar,
      status: RequestConnectionStatus.available,
    );
  }

  void updateConnection(RequestConnectionStatus status) {
    this.status = status;
  }

}