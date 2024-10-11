import 'package:demopico/features/user/domain/entities/user.dart';

//Usar senha como atributo? Firebase deve tratar isso
//Senha é passado como parâmetro nos métodos de SignIn/SignUp e não deve mais estar no código-fonte depois
//Analisar
class UserModel extends User {
  UserModel(
      {super.senha,
      super.email,
      super.vulgo,
      super.id});

  factory UserModel.fromFirebase(User firebaseUser) {
    return UserModel(
        senha: firebaseUser.senha,
        email: firebaseUser.email,
        vulgo: firebaseUser.vulgo,
        id: firebaseUser.id ?? '');
  }
}
