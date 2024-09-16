import 'package:demopico/features/user/data/models/user_model.dart';
import 'package:demopico/features/user/domain/entities/user.dart';

class UserCredentials extends UserModel {
  UserCredentials(
      {required super.senha,
      required super.email,
      required super.vulgo,
      required super.id});

  factory UserCredentials.fromFirebase(User firebaseUser) {
    return UserCredentials(
        senha: firebaseUser.senha,
        email: firebaseUser.email,
        vulgo: firebaseUser.vulgo,
        id: firebaseUser.id ?? '');
  }
}
