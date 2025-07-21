import 'package:demopico/core/app/auth_wrapper.dart';
import 'package:demopico/core/app/home_page.dart';
import 'package:demopico/features/user/presentation/widgets/login_form.dart';
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
          const Center(
            child: LoginForm(),
          ),
          Positioned(
            top: 36,
            left: 12,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_left,
                color: Colors.white,
                size: 50,
              ),
              onPressed: () {
                Get.off(() => const AuthWrapper());
                Get.to(() => const HomePage(),
                    transition: Transition
                        .leftToRightWithFade); // Navega para a tela anterior
              },
            ),
          ),
        ],
      ),
    );
  }
}
