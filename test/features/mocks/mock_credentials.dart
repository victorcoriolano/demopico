import 'package:demopico/core/common/auth/domain/entities/user_credentials.dart';
import 'package:demopico/features/user/domain/enums/identifiers.dart';

final UserCredentialsSignIn userCredentialsSignInEmail = UserCredentialsSignIn(
    identifier: Identifiers.email, login: "email@valido", senha: "senha");

final UserCredentialsSignIn userCredentialsSignInVulgo = UserCredentialsSignIn(
    identifier: Identifiers.vulgo, login: "login", senha: "senha");

final UserCredentialsSignUp userCredentialsSignUp = UserCredentialsSignUp(
    password: "password",
    uid: "uid",
    nome: "nome",
    isColetivo: false,
    email: "email@");
