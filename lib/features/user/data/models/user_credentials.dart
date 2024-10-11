import 'package:demopico/features/user/data/models/user_model.dart';
import 'package:demopico/features/user/domain/entities/user.dart';

class UserCredentials extends UserModel {
  UserCredentials({required super.email, required super.vulgo});

  factory UserCredentials.fromFirebase(User firebaseUser) {
    return UserCredentials(
        email: firebaseUser.email, vulgo: firebaseUser.vulgo);
  }
}
