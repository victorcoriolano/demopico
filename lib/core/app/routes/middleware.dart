import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/features/user/domain/enums/auth_state.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Middleware extends GetMiddleware {
  final AuthViewModelAccount authRepository;

  Middleware(this.authRepository);

  @override
  RouteSettings? redirect(String? route) {
    final currentAuthState = authRepository.authState;
    debugPrint('Current auth: $currentAuthState');

    return switch (currentAuthState) {
      AuthAuthenticated() => null,
      AuthUnauthenticated() => const RouteSettings(name: Paths.login),
    };
  }
}
