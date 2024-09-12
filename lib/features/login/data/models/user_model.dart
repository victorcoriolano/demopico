import 'package:demopico/features/login/domain/entities/user.dart';

class UserModel extends User {
  UserModel(
      {required super.senha,
      required super.email,
      required super.vulgo,
      required super.id});

  factory UserModel.fromFirebase(User firebaseUser) {
    return UserModel(
        senha: firebaseUser.senha,
        email: firebaseUser.email,
        vulgo: firebaseUser.vulgo,
        id: firebaseUser.id ?? '');
  }
}
