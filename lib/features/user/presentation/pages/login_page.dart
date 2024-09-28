import 'package:demopico/features/user/presentation/widgets/login_form_pc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/containerLogin.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), // Ajuste a opacidade aqui
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_left,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                Get.back(); // Navega para a tela anterior
              },
            ),
          ),
          const Center(
            child: LoginForm(),
          ),
        ],
      ),
    );
  }
}
