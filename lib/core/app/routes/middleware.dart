import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:demopico/features/user/presentation/controllers/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Middleware extends GetMiddleware {

  final _authProvider = Get.find<ProfileViewModel>();
  
  @override
  RouteSettings? redirect(String? route) {

      if (_authProvider.user == null) return RouteSettings(name: Paths.login);
      return null; // não redireciona caso o user esteja logado 
  }
}
