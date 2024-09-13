
import 'package:demopico/features/login/presentation/controllers/login_controller.dart';
import 'package:demopico/features/login/presentation/widgets/login_form_pc.dart';
import 'package:flutter/material.dart';


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
                image: const AssetImage('assets/containerLogin.jpg'),
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
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,size: 40,),
              onPressed: () {
                Navigator.pop(context); // Navega para a tela anterior
              },
            ),
          ),
          const Center(
            child: LoginForm(loginController: LoginController(
              authService: ,
              firebaseService: ,
            )),
          ),
        ],
      ),  
    );
  }
}