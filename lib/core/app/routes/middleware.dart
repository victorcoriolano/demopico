import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/features/user/presentation/controllers/user_database_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthGard extends GetMiddleware {
  final authService = UserDatabaseProvider.getInstance;

  @override
  RouteSettings? redirect(String? route) {

      if (authService.user == null) return RouteSettings(name: Paths.login);
      return null; // não redireciona caso o user esteja logado 
  }
}
