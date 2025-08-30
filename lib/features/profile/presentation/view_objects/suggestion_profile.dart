

import 'package:demopico/features/profile/domain/models/connection.dart';
import 'package:demopico/features/user/domain/models/user.dart';

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

  factory SuggestionProfile.fromUser(UserM user) {
    return SuggestionProfile(
      idUser: user.id,
      name: user.name,
      photo: user.pictureUrl,
      status: RequestConnectionStatus.available,
    );
  }

  void updateConnection(RequestConnectionStatus status) {
    this.status = status;
  }

}