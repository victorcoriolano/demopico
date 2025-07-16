import 'package:demopico/features/user/domain/enums/sign_methods.dart';

abstract class UserCredentials {
  SignMethods get signMethods => SignMethods.notDetermined;
  
}

class UserCredentialsSignIn implements UserCredentials {
  final String email;
  final String password;
  final SignMethods signMethod;

  UserCredentialsSignIn({
    required this.signMethod, 
    required this.email,
    required this.password,
  });
  
  @override
  SignMethods get signMethods => signMethod;
}

class UserCredentialsSignInVulgo implements UserCredentials {
  final String vulgo;
  final String password;
  final SignMethods signMethod;

  UserCredentialsSignInVulgo({
    required this.signMethod,
    required this.vulgo,
    required this.password,
  });
  
  @override
  SignMethods get signMethods => signMethod;

  
}

class UserCredentialsSignUp {
  final String uid;
  final String nome;
  final bool isColetivo;
  final UserCredentialsSignIn credentials;

  UserCredentialsSignUp({
    required this.uid,
    required this.nome,
    required this.isColetivo,
    required this.credentials,
  });
}
