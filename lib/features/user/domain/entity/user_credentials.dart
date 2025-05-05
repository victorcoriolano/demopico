class UserCredentialsSignIn {
  final String email;
  final String password;

  UserCredentialsSignIn({
    required this.email,
    required this.password,
  });
}

class UserCredentialsSignUp {
  final String nome;
  final bool isColetivo;
  final UserCredentialsSignIn credentials;

  UserCredentialsSignUp({
    required this.nome,
    required this.isColetivo,
    required this.credentials,
  });
}
