import 'package:demopico/features/user/domain/enums/identifiers.dart';
import 'package:demopico/features/user/domain/enums/sign_methods.dart';


class UserCredentialsSignIn {
  final Identifiers identifier;
  String login; // não é final por que pode mudar no caso de logar com o vulgo no qual irá alterar o login em tempo de execução
  final String senha;
  final SignMethods signMethod;

  UserCredentialsSignIn({
    SignMethods? signMethods, 
    required this.identifier,
    required this.login,
    required this.senha,
  }) : signMethod = signMethods ?? SignMethods.email;

  // método para alterar login no caso de ir logar 
  void setLogin(String login){
    this.login = login;
  }
}


class UserCredentialsSignUp {
  final String uid;
  final String nome;
  final bool isColetivo;
  final String email;
  final SignMethods signMethod;
  final String password;
  

  UserCredentialsSignUp({
    required this.password,
    required this.signMethod,
    required this.uid,
    required this.nome,
    required this.isColetivo,
    required this.email,
  });
}
