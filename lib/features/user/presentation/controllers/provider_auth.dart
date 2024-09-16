import 'package:demopico/core/domain/entities/user_profile.dart';
import 'package:demopico/core/domain/interfaces/register_params.dart';
import 'package:demopico/core/domain/usecases/login/sign_up_use_case.dart';
import 'package:demopico/core/domain/usecases/login/login_use_case.dart';
import 'package:demopico/features/user/data/repositories/login_params.dart';
import 'package:demopico/features/user/data/services/auth_service.dart';
import 'package:demopico/features/user/domain/entities/user.dart';
import 'package:demopico/features/user/presentation/controllers/login_controller.dart';
import 'package:flutter/foundation.dart';

class ProviderAuth extends ChangeNotifier {
  final LoginController loginController;
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  LoggedUser? _user;
  User? get user => _user;
  AuthService authService;
  ProviderAuth(
      {required this.loginUseCase,
      required this.registerUseCase,
      required this.authService,
      required this.loginController});

  Future<void> login(String email, String senha) async {
    final result =
        await loginUseCase(LoginParams(email: email, password: senha));
    result.fold(
      (failure) {
        failure.toString();
      },
      (user) {
        _user = user;
        authService.login(email, senha);
        notifyListeners();
      },
    );
  }

  Future<void> register(String email, String password) async {
    final result =
        await registerUseCase(RegisterParams(email: email, password: password));
    result.fold(
      (failure) {
        failure.toString();
      },
      (user) {
        _user = user;
        authService.register(email, password);
        notifyListeners();
      },
    );
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
