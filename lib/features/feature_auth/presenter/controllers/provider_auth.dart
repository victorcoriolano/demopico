import 'package:barna_chat/feature_auth/domain/entities/user.dart';
import 'package:barna_chat/feature_auth/domain/usecases/cadastro_uc.dart';
import 'package:barna_chat/feature_auth/domain/usecases/login_use_case.dart';
import 'package:flutter/foundation.dart';

class ProviderAuth  extends ChangeNotifier{
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  User? _user;
  User? get user => _user;

  ProviderAuth({required this.loginUseCase, required this.registerUseCase});

  Future<void> login(String email, String senha) async {
    final result = await loginUseCase(LoginParams(email: email, password: senha));
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
    final result = await registerUseCase(RegisterParams(email: email, password: password));
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

  void logout(){
    _user = null;
    notifyListeners();
  }


}