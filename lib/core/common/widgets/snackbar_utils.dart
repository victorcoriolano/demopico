import 'package:demopico/core/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarUtils extends SnackBar {
  const SnackbarUtils({
    super.key,
    required super.content,
    super.action,
  });

  static void userNotLogged(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Usuário não logado"),
        action: SnackBarAction(
          label: "Fazer login",
          onPressed: () => Get.toNamed(Paths.login),
        ),
      ),
    );
  }
}
