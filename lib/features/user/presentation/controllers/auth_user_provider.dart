import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/core/common/errors/repository_failures.dart';
import 'package:demopico/features/user/domain/aplication/validate_credentials.dart';
import 'package:demopico/core/common/auth/domain/entities/user_credentials.dart';
import 'package:demopico/features/user/domain/enums/identifiers.dart';
import 'package:demopico/features/user/domain/usecases/criar_conta_uc.dart';
import 'package:demopico/features/user/domain/usecases/login_uc.dart';
import 'package:demopico/features/user/domain/usecases/logout_uc.dart';
import 'package:demopico/features/user/domain/usecases/pegar_id_usuario.dart';
import 'package:demopico/features/user/presentation/controllers/user_data_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthUserProvider extends ChangeNotifier {
  static AuthUserProvider? _authUserProvider;

  static AuthUserProvider get getInstance {
    _authUserProvider ??= AuthUserProvider(
        criarContaUc: CriarContaUc.getInstance,
        loginEmailUc: LoginUc.getInstance,
        validateUserCredentials: ValidateUserCredentials.instance,
        logoutUc: LogoutUc.getInstance,
        pegarIdUsuario: PegarIdUsuario.getInstance, 
        userDatabaseProvider: UserDataViewModel.getInstance);
    return _authUserProvider!;
  }

  AuthUserProvider(
      {required this.pegarIdUsuario,
      required ValidateUserCredentials validateUserCredentials,
      required this.userDatabaseProvider,
      required this.criarContaUc,
      required this.loginEmailUc,
      required this.logoutUc})
      : _validateUserCredentials = validateUserCredentials;

  final CriarContaUc criarContaUc;
  final LoginUc loginEmailUc;
  final LogoutUc logoutUc;
  final PegarIdUsuario pegarIdUsuario;
  final ValidateUserCredentials _validateUserCredentials;
  final UserDataViewModel userDatabaseProvider;

  bool isColetivo = false;
  bool isEmail = true;
  Identifiers identifier = Identifiers.email;
  String? _idUser;

  bool isLoading = false;

  String? errorMessageEmail;
  String? errorMessageVulgo;
  String? genericError;

  set setIdUser(String? id) {
    _idUser = id;
  }

  String? get idUser => _idUser;

  void changeIsEmail() {
    isEmail = !isEmail;
    identifier = isEmail ? Identifiers.email : Identifiers.vulgo;
    notifyListeners();
  }

  void changeIsColetivo() {
    isColetivo = !isColetivo;
    notifyListeners();
  }

  Future<void> login(UserCredentialsSignIn credentials) async {
    credentials.login = credentials.login.toLowerCase();
    try {
      final validatedCredentials =
          await _validateUserCredentials.validateForLogin(credentials);
      final user = await loginEmailUc.logar(validatedCredentials);
      setIdUser = user.id;
      userDatabaseProvider.setUser = user;
    } on Failure catch (e) {
      getError(e);
    } catch (e) {
      getError(UnknownFailure(unknownError: e));
    }
  }

  void getError(Failure e, [String? message]) {
    final messageError = message ?? "ERRO";
    Get.snackbar(messageError, e.message);
  }

  Future<void> logout() async {
    try {
      userDatabaseProvider.setUser =  null; // Limpando o usuário do provider   
      await logoutUc.deslogar();
    } on Failure catch (e) {
      getError(e, "Erro ao deslogar");
    }
  }

  Future<void> signUp(UserCredentialsSignUp credentials) async {
    //limpando mensagens de erro a cada tentativa para
    // evitar que o mesmo erro esteja como não nullo
    clearMessageErrors();
    isLoading = true;
    notifyListeners();
    try {
      final validCredentials =
          await _validateUserCredentials.validateForSignUp(credentials);
      final newUser = await criarContaUc.criar(validCredentials);
      UserDataViewModel.getInstance.setUser = newUser;
      isLoading = false;
      notifyListeners();
    } on Failure catch (e) {
      switch (e.runtimeType) {
        case (VulgoAlreadyExistsFailure _):
          {
            debugPrint("Erro no vulgo - vulgo já existe");
            errorMessageVulgo = e.message;
            isLoading = false;
            notifyListeners();
            getError(e);
          }
        case (EmailAlreadyExistsFailure _):
          {
            debugPrint("Erro no email - email já existe");
            errorMessageEmail = e.message;
            isLoading = false;
            notifyListeners();
            getError(e);
          }
        default:
          {
            genericError = e.message;
            isLoading = false;
            notifyListeners();
            getError(e);
          }
      }
    } catch (e) {
      genericError = e.toString();
      isLoading = false;
      notifyListeners();
      getError(UnknownFailure(unknownError: e));
    }
  }

  void clearMessageErrors() {
    errorMessageEmail = null;
    errorMessageVulgo = null;
    genericError = null;
    notifyListeners();
  }

  String? get currentIdUser {
    final id = pegarIdUsuario.pegar();
    setIdUser = id;
    return id;
  }
}
