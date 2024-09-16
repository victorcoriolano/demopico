import 'package:demopico/core/domain/interfaces/register_params.dart';
import 'package:demopico/core/domain/usecases/login/sign_up_use_case.dart';
import 'package:demopico/core/domain/usecases/login/login_use_case.dart';
import 'package:demopico/features/user/data/repositories/login_params.dart';
import 'package:demopico/features/user/domain/entities/user.dart';
import 'package:flutter/foundation.dart';

class ProviderAuth extends ChangeNotifier {

  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  User? _user;
  User? get user => _user;

  ProviderAuth(
      {required this.loginUseCase,
      required this.registerUseCase,}
      );

  Future<void> login(String email, String senha) async {
    final result =
        await loginUseCase(LoginParams(email: email, password: senha));
    result.fold(
      (failure) {
        failure.toString();
      },
      (user) {
        _user = user;
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
        notifyListeners();
      },
    );
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
